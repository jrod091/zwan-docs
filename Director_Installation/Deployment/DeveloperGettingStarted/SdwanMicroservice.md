# Creating and Deploying SDWAN Microservices 

## Create SDWAN Microservice 


1.  Clone Generator Project: 

    Clone kubernaut-service-generator into a directory with the new service name. 

```
    #New service will be named test-service 
    $ git clone https://172.16.120.65/samb/kubernaut-service-generator.git test-service 
     
    #Example to show that source from kubetnaut-service-generator is directly in test-service directory 
    $ cd test-service 
    $ ls 
    README.md scripts templates 
```

2.  Generating Service Project 

    generate-service.sh - Convert cloned kubernaut-service-generator project into a new GQL service project. 

```
    # Important to use '. ./scripts/generate-service.sh' instead of './scripts/generate-service.sh'  
    
    $ . ./scripts/generate-service.sh 
    
    Gitlab Host (172.16.120.65): 
    Gitlab User: <user> 
    Service name / Project slug (test-service):  
    Removing Git 'kubernaut-service-generator' origin. 
    Removing generate script. 
    Updating README. 
    Initializing new GIT repo for service. 
    Getting service boilerplate. 
    Updating service metadata. 
    Staging all project generation changes. 
    Adding remote repo to project. 
    Pushing project to Gitlab. 
    Generated 'https://172.16.120.65/<user>/test-service.git' successfully. 
```

3. Move 'https://172.16.120.65/<user>/test-service.git' to 'https://172.16.120.65/sdwan/test-service.git' 

4. Add CI/CD runner file .gitlab-ci.yml and commit to GIT. 

```
    variables: 
      SRCPATH: ./service 
     
    include: 
      - project: 'sdwan/cicd-runner' 
        file: '/templates/micro-service-gitlab-ci.yml' 
```

5. Clone the project 'https://172.16.120.65/sdwan/test-service.git' . Add the needed service files in service folder. 

6. Commit the change to run CI/CD. Which will build and push new microservice to docker registry. 


## Adding Microservice to Ansible deployment 

### Create Helm package:  

All the microservices should build as helm package to install it via Ansible from helm repo. 

Below steps explains how to build a helm package and upload it to helm repo. 

1. helm and helm s3 plugin installation: 

```
    $ curl https://raw.githubusercontent.com/helm/helm/main/scripts/get-helm-3 | bash  
    helm plugin install https://github.com/hypnoglow/helm-s3.git  
```


2. aws cli installation 

```
    $ curl "https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip" -o "awscliv2.zip" 
    
    $ unzip -o awscliv2.zip 
    
    $ sudo ./aws/install 
```


3. aws configuration: 

```
    $ sudo aws configure set default.region us-east-1  
    
    $ sudo aws configure set aws_access_key_id '<ACCESS_KEY_ID>'  
    
    $ sudo aws configure set aws_secret_access_key '<SECRET_ACCESS_KEY>' 
    
    Note: Proved the <ACCESS_KEY_ID> and <SECRET_ACCESS_KEY> 
```


4. Helm repo addition 

```    
    $ sudo helm repo add amzettarepo s3://amz-helm-repo/charts 
```

5. GIT clone helm-packages 	 

```
    $ git clone https://gitlab.amzetta.com/sdwan/helm-packages.git -b <branch_name> 
    
    Note: Provide branch_name if available

```

6. Create and copy kubernaut service chart into s3: 

*  To create helm packages of individual service with using dependency as kubernaut-service-chart. 

*  To update the version of kubernaut-service-chart package, use the below script file with the following arguments 


```
    Command usage:
    ./create_kubernaut_package.sh kubernaut-service-chart 1.0.2 s3://amz-helm-repo/charts  
    
    Example:
    $ sudo aws s3 cp kubernaut-service-chart-1.0.2.tgz s3://amz-helm-repo/charts/  
    
    $ sudo helm s3 reindex amzettarepo 
```

7. Key points for creating new helm package  


*  To create the individual services helm package, we need values.yaml of the respective service. 

*  'values.yaml' file will be passed to the kubernaut-service-chart, it will read the values and accordingly respective action takes place. 

*  We use 'setup_create_helm_package.sh' script file for creating the helm package 

*  setup_create_helm_package.sh, script file needs some values, which will be configured in .env file and also few values should be passed in command line. 

*  Before, creating the helm package, make sure helm repo is added. 

8. Create and push new helm package to repo 


*  Take a copy of any existing help package (example: helm-packages/certificate-service) to create a new helm package. 


*  Edit helm-packages/certificate-service/values.yaml as per the helm package need. 


*  Edit the service name and app version in helm-package/certificate-service/Chart.yaml 


```
    Command Usage:
    ./setup_create_helm_packae.sh <helm chart name> <chart new version> <docker image new version> <values.yaml of microservice>
    
    Example:
    $ sudo ./setup_create_helm_package.sh certificate-service 1.0.2 1.0.2 certificate-service/values.yaml 
    
    $ sudo aws s3 cp certificate-service-1.0.2.tgz s3://amz-helm-repo/charts/  
    
    $ sudo helm s3 reindex amzettarepo 
```

### Installing helm package via Ansible deployment 

1. Git clone deployment source: 

```
    $ git clone https://gitlab.amzetta.com/sdwan/deployment.git -b <branch_name>
    
    Note: Provide <branch_name>. Currently “development” branch_name
```

2. Create a tag of helm service package (example: Tag version 0.2.4 for certificate-service from  https://172.16.120.65/sdwan/certificate-service) 

3. Add the new service version in deployment/setup/host-templates/vars_main.yml
 
```
    Example: 
 
    CERTIFICATE_SERVICE_TAG: 0.2.4 
```

4. For installing the helm package using ansible deployment. We need to create separate helm package installer YML file for every package. For example, let's take certificate-service helm chart installed in northbound namespace services (deployment/setup/roles/clustersvc/tasks/amzservices/northbound/certificate.yml)	 

```
    - name: Adding certificate-service chart 
            helm: 
               name: certificate-service 
               chart_ref: amzettarepo/certificate-service 
               chart_version: 1.0.2 
               release_namespace: northbound 
               create_namespace: true 
               values: 
                 global: 
                    dockerRegistry: "{{ VALUES.DOCKER_REGISTRY }}" 
                 kubernaut-service-chart: 
                    image: 
                        tag: "{{ VALUES.CERTIFICATE_SERVICE_TAG }}" 
                         
            register: ret_val 
            until: (ret_val.failed == False) 
            retries: 5 
            delay: 1 
            ignore_errors: yes 
      
          - name: Get certificate-service helm info 
            kubernetes.core.helm_info: 
              name: certificate-service 
              release_namespace: northbound 
            register: certificate_service_ret_val 
    
          - name: certificate-service check 
            any_errors_fatal: true 
            fail: 
              msg: "Failed to install certificate-service helm package" 
            when: (ret_val.failed == True) or (certificate_service_ret_val.status.status is defined and certificate_service_ret_val.status.status != "deployed") 
```

5.  Add the helm package installer YML file to Ansible deployment 

    For example, add certificate.yml as ansible task by adding following task snippet to deployment/setup/roles/clustersvc/tasks/amzservices/northbound/install-northbound.yml 

```
    - name: Adding certificate-service chart 
      include_tasks: ./certificate.yml 
```

    install-northbound.yml will be called from deployment/setup/roles/clustersvc/tasks/amzservices/install-amzservices.yml 