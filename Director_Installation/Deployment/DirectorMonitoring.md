# Director Health monitoring
Director health like node failure, link failure, services down, disk utilization are continuously monitored and system administrators are notified by email. 
The director monitors status of the below and send email alert. 
 - Cluster Node status (Down/Up).
 - Microservice status (Down/Up).
 - Disk space (Node running on low disk space).

----
The monitoring and email notification is configured during the deployment.

> Note:
If any notifications are received while deploying the director, we can ignore. We have to respond to the alarms as soon as the deployment is finished and they are received.

Follow the below steps if its not configured during the deployment or update the configuration. 

## Steps to install and configure monitoring and notification in existing director deployment:
- Login to  k3s vm
- Create a file called /home/vagrant/zwan/alert-values.yaml  in one of the k3s vm, change the file permission to 774 and add the below details into it. Mention replicacount as 1 for standalone and  3 for HA[BASED-ON-DIRECTOR-CLUSTER-COUNT]
```sh
USER-SUPPLIED VALUES:
replicaCount: <BASED-ON-DIRECTOR-CLUSTER-COUNT>
config:
  global:
    resolve_timeout: 5m
  receivers:
  - email_configs:
    - auth_identity: "<FROM-EMAIL-ADDRESS>"
      auth_password: "<FROM-EMAIL-ADDRESS-PASSWORD>"
      auth_username: "<FROM-EMAIL-ADDRESS>"
      from: "<FROM-EMAIL-ADDRESS>"
      smarthost: "<SMTP-HOST>:<SMTP-PORT>"
      to: "<TO-EMAIL-ADDRESS>"        
      require_tls: true
      headers:
        subject: '{{ template "custom_mail_subject" . }}'
      html: '{{ template "custom_mail_html" . }}'
    name: email-receiver

  route:
    receiver: email-receiver
  templates:
  - '/etc/alertmanager/templates/mail_template.tmpl'
extraVolumeMounts: 
- name: extras
  mountPath: /etc/alertmanager/templates/
  readOnly: true
extraVolumes:
- name: extras
  hostPath:
    path: /home/vagrant/zwan/alertmanager/
    type: Directory
```
- Execute the below commands to install the prometheus alertmanager
```sh
1) helm repo update
2) helm install prometheus-alertmanager amzettarepo/alertmanager --version 1.11.0 -n istio-system  --values /home/vagrant/zwan/alert-values.yaml
3) Verify the pods are up and running as 2/2 containers
    1)  kubectl get pods -n istio-system
```
> Note:
    1)  Use comma to pass multiple to address email configuration. 
    2)  Prometheus alertmanger not having the support for cc and bcc email address. If needed we can pass in to address.
    
### Steps to include the kuberneres node disk pressure alert
- Edit the prometheus-server config-map inside the k3s
```sh
kubectl edit cm prometheus-server -n istio-system
```
- Add the kubernetes disk pressure alert  under rules in alerting_rules.yaml. Above the Microservice Down alert. Save the file
```sh
- alert: KubernetesNodeDiskPressure
annotations:
  summary: Kubernetes Node disk pressure (instance {{ $labels.instance }})
  description: "Node {{ $labels.node }} has DiskPressure condition\n  VALUE = {{ $value }}\n  LABELS = {{ $labels }}"
  prometheus_url: 'Prometheus url: http://10.200.4.240:20001/'
expr: kube_node_status_condition{condition="DiskPressure",status="true"} == 1
for: 2m
labels:
  severity: critical
```
- Restart the prometheus-server
```sh
kubectl rollout restart statefulset prometheus-server -n istio-system
```
- Wait for the prometheus-server to be up and running 2/2
```sh
kubectl get pods -n istio-system
```
## Steps to update existing configuration:
- Edit the prometheus-alertmanager config-map  inside the k3s
```sh	
kubectl edit cm prometheus-alertmanager -n istio-system
```
			
- Change the auth_identity, auth_username, from vraibles to the from email address, change auth_password to from email address password, change the smarthost to the smtp server host:port and change the to address if needed. And save the file
	
- Restart the prometheus-alertmanager
```sh		
kubectl rollout restart statefulset prometheus-alertmanager -n istio-system
```
			
- Wait for the all the alertmanager to be up and running 2/2
```sh
kubectl get pods -n istio-system
```
-  Verify whether the mails are coming to new email address instead of older address.
	
### Steps to enable the gmail smtp server to send the alerts: 
- Open Your Gmail Account > security > 2-step verification(enable it).
- Go to App Passwords > select device > select app(you can create custom app). And click on generate
- Copy App Password and use it as a auth_password for the respective gmail id.
		
