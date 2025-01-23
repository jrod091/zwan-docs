# zWAN Deployment - User Guide

## Introduction

zWAN is AmZetta’s implementation of SDWAN solution. zWAN is targeted towards small to midsize enterprises that are looking to incorporate SDWAN into their networking infrastructure.

AmZetta’s zWAN is composed of two major parts

A centralized management/orchestration server (or cluster of servers)/director is responsible for the management plane and certain control plane activities.

A distributed edge controller(s) that is responsible for data-plane activities.

    This document explains the deployment of director in a Standalone and Cluster (High Availability) Setup.

## Requirements

### 1. Installer Host

Ubuntu 22.04 in Virtual or Physical Machine.

Yaml Installation

Deployment Binaries

### 2. Director Host

#### 2.1. Standalone Setup

Ubuntu server 22.04 with H/W configuration as below

- Storage – 600GB

- RAM – 64GB

- CPU - 16 cores

- 1 NIC

#### 2.2. Cluster Setup

3 systems with the below configuration.

Ubuntu server 22.04 with H/W configuration as below

- Storage – 600GB

- RAM – 64GB

- CPU - 16 cores

- 3 NICs

- 1 for WAN

- 2 for LAN side – Connected to a switch. These interfaces need to be up and IP need not be assigned for them.

## 3. Installation

### Prerequisites

Prerequisites in the installer and the director host are installed automatically from the scripts.
In the installer host, **pre_req.sh** needs to be run before **setup.sh**, installs the required software components.
In the director host, the ansible playbooks takes care of the installation of S/W requirements, the playbooks are called from **setup.sh**

Note:

1.<span style="color: red"> Scripts needs to be run only in user mode. </span>

2.If diab setup is already installed in the Remote Host, remove the same using the **destroy.sh** and make sure the VM’s and iptables rules are deleted.

### Configuration

1. Copy the zwan provider source to installer host.
2. Login to installer host and go the file copied location.
3. Go to deployment/setup location
4. Modify the **master.yml** file with the valid server details.

Give the valid server details in the **master.yml** file (Comments are added to each section)

### Installation for Standalone setup

Note:

- If CPE VM’s needs to be retained, comment the lines in the **destroy.sh** related to CPE VMs.

- To delete the exiting ansible setup, run following cleanup command using the same file used for setup.
  
    **./setup.sh standalone cleanup**

### Steps to install standalone setup

- To start the setup in the director host

- Login to installer host and go to the deployment/setup location

- **./pre_req.sh** - Install the S/W requirements in the installer system

- **./setup.sh standalone** - Validates the S/W and H/W requirements in the director hosts, creates the VM with the components.
- The installation will create below 4 VM’s in each director host.
  - K3s
  - Mongo
  - Openvpn
  - Elk
- On Successful installation - An MSP (Managed Server provider) account is created - One default tenant account is created
  Note: CPEs won't be created.
- Sample **master.yaml** file for Standalone setup

```
 Server 1 ip, user, password details
- ip: 10.200.4.3
  name: server2
  user: user
  password: password
Master component will install k3s, openvpn, mongo and elk vms, DONT EDIT THIS ENTRY
  components:
    - Master:
      - name: elk
        cpu: 8
        memory: 32GB
vxlan_id: 199
#Director site type: available director type DC|DR (DC- active or DR- passive)
director_site: "DC"
install_msp: 1
install_tenant: 1
external_disk:
  analytics_disk_size: 100
  analytics_data_path: /media/disk1/elkdata
  minio_disk_size: 100
  minio_data_path: /media/disk1/miniodata
```

zWAN director support both IPv4 and IPv6. Please refer [IPv6](/Director_Installation/Deployment/IPv6.md) for IPv6 details. 

### Installation for Cluster setup

Note:

- If CPE VM’s needs to be retained, comment the lines in the **destroy.sh** related to CPE VMs.
- To delete the exiting ansible setup, run following cleanup command using the same file used for setup.
  
    **./setup.sh cleanup**

### Steps to install Cluster setup
- To start the setup in the director host
- Login to installer host and go to the deployment/setup location
- **./pre_req.sh** - Install the S/W requirements in the installer system
- **./setup.sh** - Validates the S/W and H/W requirements in the director hosts, creates the VM with the components.
- The installation will create below 4 VM’s in three director host.
  - K3s
  - Mongo
  - Openvpn
  - Elk
- On Successful installation - An MSP (Managed Server provider) account is created - One default tenant account is created
  Note: CPEs won't be created.
- Sample **master.yml** file for Cluster Setup

```
servers:
Server 1 ip, user, password details
  - ip: 10.200.48.108
    port: 22
    name: ubuntu3
    user: user
    password: ubuntu@123
Master component will install k3s, openvpn, mongo and elk vms, DONT EDIT THIS ENTRY
  components:
    - Master:
      - name: elk
        cpu: 8
        memory: 32GB
    lan-nics:
Server 1 LAN interface names as displayed with ip -br a command. These two interfaces will be connected to
a switch. IP need not be assigned to them.
      - enp4s0f0
      - enp4s0f1
# Provide the interface name to which the Public IP is mapped, the below value is used only for public ip.
# With public ip systems the interface cannot be identified with the serverip, if the below value is not provided
# vxlan interface creation will fail.
# Add host_interface as an array. Maximum 3 interface. First interface will be conside as primary interface.
    host_interface: 
      - eno1
      - eno2
      - eno3
Server 1 - Ip value to configure for the bond interface created with the lan interfaces.
Please make sure the subnet of the all the bond ips (configured for server1, 2 and 3) are same.
    bond_ip: 20.0.0.31
Server 2 ip, user & password details
  - ip: 10.200.48.12
    port: 22
    name: ubuntu2
    user: user
    password: ubuntu@123
Master component will install k3s, openvpn, mongo and elk vms, DONT EDIT THIS ENTRY
  components:
    - Master:
      - name: elk
        cpu: 8
        memory: 32GB
Server 2 LAN interface names as displayed with ip -br a command. These two interfaces will be connected to
a switch. IP need not be assigned to them.
    lan-nics:
      - enp4s0f0
      - enp4s0f1
# Provide the interface name to which the Public IP is mapped, the below value is used only for public ip.
# With public ip systems the interface cannot be identified with the serverip, if the below value is not provided
# vxlan interface creation will fail.
# Add host_interface as an array. Maximum 3 interface. First interface will be conside as primary interface.
    host_interface: 
      - eno1
      - eno2
      - eno3
Server 2 - Ip value to configure for the bond interface created with the lan interfaces.
Please make sure the subnet of the all the bond ips (configured for server1, 2 and 3) are same.
    bond_ip: 20.0.0.32
Server 3 ip, user, password details
  - ip: 10.200.48.37
    port: 22
    name: ubuntu
    user: user
    password: user
Master component will install k3s, openvpn, mongo and elk vms, DONT EDIT THIS ENTRY
  components:
    - Master:
      - name: elk
        cpu: 8
        memory: 32GB
Server 3 LAN interface names as displayed with ip -br a command. These two interfaces will be connected to
a switch. IP need not be assigned to them.
    lan-nics:
      - enp4s0f0
      - enp4s0f1
# Provide the interface name to which the Public IP is mapped, the below value is used only for public ip.
# With public ip systems the interface cannot be identified with the serverip, if the below value is not provided
# vxlan interface creation will fail.
# Add host_interface as an array. Maximum 3 interface. First interface will be conside as primary interface.
    host_interface: 
      - eno1
      - eno2
      - eno3
Server 3 - Ip value to configure for the bond interface created with the lan interfaces.
Please make sure the subnet of the all the bond ips (configured for server1, 2 and 3) are same.
    bond_ip: 20.0.0.33
keepalived:
# For HA setup host_vrrp_ip and host_vrrp_id should be provided.
# The Count and Order of host interfaces and keepalived IPs should be matched.
# Provider Host keepalived IP(host_vrrp_ip) which will be shifted among the Servers. The IP should be in the SAME SUBNET as the 3 Servers.
   - host_vrrp_ip: 10.200.4.239
# Provider Host VRRP ID(host_vrrp_id) to be unique for each HA setup
     host_vrrp_id: 239
# vxlan group id to be unique for each setup
vxlan_id: 412
# Public IP to be configured
external_ip:
  - 10.200.4.2
  - 10.200.4.234
# Director site type args: ( DC or DR )
director_site: "DC"
# Default value is the public docker repo
docker_registry: 
# Setting the value 1, means default msp account will be created. Leave it empty, while restoring deployment.
install_msp: 1
# Setting the value 1, means default tenant account will be created. Leave it empty, while restoring deployment.
install_tenant: 1
## Provide disk size in GB, setting the value to 0 means no external disk will be created.
external_disk:
## Used for storing the analytics data. Leave empty for default.
  analytics_disk_size: 100
## Provide external disk path to store Analytics data. Leave empty for default.
  analytics_data_path: /media/disk1/elkdata
## Used for storing the backup data. Leave empty for default.
  minio_disk_size: 100
## Provide external disk path to store Minio data. Leave empty for default.
  minio_data_path: /media/disk1/miniodata
```

### Installation Configuration.
Installation requires few configuration to be entered during installation. 

#### Configure ZWAN Credentials: It will ask user to configure login password for msp, tenant and minio

    >   Configure ZWAN Credentials:
        Do you want to set global login password for MSP, TENANT and MINIO (y/n): n
        Enter the MSP User password: 
        Enter the MSP User confirm password: 
        Enter the Tenant User password: 
        Enter the Tenant User confirm password: 
        Enter the Minio User password: 
        Enter the Minio User confirm password: 

    or 

    >   Configure ZWAN Credentials:
        Do you want to set global login password for MSP, TENANT and MINIO (y/n): y
        Enter the global User password: 
        Enter the global User confirm password: 

### Director Update

1.  Make sure the previous versions are installed in director host.
2.  Copy the new zwan provider source to installer host.
3.  Login to installer host and go the file copied location.
4.  Go to deployment/setup location
5.  Modify the **master.yml** file with the valid server details which is deployed already.
6.  Give the command to update in following format

    **`./setup.sh [standalone] update <component-1> <component-2> .... <component-N>`**

        Example:
            ./setup.sh [standalone] update clustersvc

            ./setup.sh [standalone] update hostinterface elk openvpn zid clustersvc externalsvc msp tenant nginx

    **Note: Before updating Nginx, if custom SSL certificates are installed they should be backed up, if they need to be preserved.**
             
        Default key and certificate files are
             1. /etc/nginx/ssl/zwan-director.key
             2. /etc/nginx/ssl/zwan-director.crt
    

8.  Following are the update supported component names.

    - nginx
    - hostinterface
    - elk 
    - openvpn 
    - zid 
    - clustersvc 
    - externalsvc 
    - msp 
    - tenant 


**Component Name: clustersvc**

    a) namespace: datastore
        1) redis-operator
        2) rfr-redis
        3) rfs-redis
    b) namespace: longhorn-system (This is a cluster setup spceific component )
        1) csi-attacher
        2) csi-provisioner
        3) csi-resizer
        4) csi-snapshotter
        5) engine-image-ei
        6) instance-manager-e
        7) instance-manager-r
        8) longhorn-admission-webhook
        9) longhorn-conversion-webhook
        10) longhorn-csi-plugin
        11) longhorn-driver-deployer
        12) longhorn-manager
        13) longhorn-ui
        14) share-manager-pvc
        15) longhorn-recovery-backend
    c) namespace: network-optimizer
        1) flow-optimizer
        2) twamp-result
        3) twamp-scheduler
    d) namespace: northbound
        1) alerting
        2) certificate-processor
        3) certificate-service
        4) db-backup-and-restore-manager
        5) dc-monitor
        6) debug-dump
        7) ec-event-receiver
        8) edge-controller-provisioner
        9) edge-controller-proxy
        10) firmware-manager
        11) management-service
        12) mesh-event-handler
        13) mesh-manager
        14) sensor-event-monitor
        15) shadow-db
        16) template-builder
        17) tenant-service
        18) web-ssh
        19) remote-nms
    e) namespace: queue-worker
        1) event-processor
        2) fw-update-processor
        3) policy-processor
        4) results-processor
        5) shadow-db-processor
        6) cpe-backup-restore-processor
    f) namespace: southbound
        1) edge-controller-manager
    g) namespace: topology
        1) topo-discover
    h) namespace: cpe-controller
        1) edge-controller-proxy


**Component Name: zid**

    a) namespace: zid
    	1) postgres-operator
    	2) postgres-cluster
    	3) zid


**Component Name: externalsvc**

    1) alpsee-ui
    2) mapikarp-ui
    3) minio
    4) msp
    5) zwangateway


**Component Name: elk**

    1) zwan-analytics-webserver
    2) zwan-analytics-kibana
    3) zwan-analytics-logstash
    4) zwan-analytics-elasticsearch
    5) zwan-analytics-curator
    
    
**Component Name: hostinterface** (If any update in WAN interface)

### Troubleshooting
 - Director Installation fails due to timeout - Some time downloading images from repository takes time to download in slow network and timeout is triggered and fails with timeout. In such cases retry the installation. 

### Limitations

- Two systems should always be up at any point of time.
- Minimum 20 secs will be taken to shift the Host Keepalived incase if any of the k3s, openvpn or elk vm is not running.

### Known Issues

- Unknown interface issue may happen
- Harpin NAT issue
  - Some routers have issue in routing the packets back when its public IP is accessed from inside the LAN network. In that case a IP table rules are required as below 
  ```
    #iptables -t nat -I PREROUTING 1 -d <external_ip>/32 -p tcp -m tcp --dport 8082 -j DNAT --to-destination <zid_vm_ip>

    Example:
    #iptables -t nat -I PREROUTING 1 -d 4.21.30.248/32 -p tcp -m tcp --dport 8082 -j DNAT --to-destination 192.168.77.1 
    #iptables -t nat -A PREROUTING -p tcp -m tcp --dport 7081 -j DNAT --to-destination 192.168.77.1 
  ```
 

 


## HA Setup Representation

![custom](images/HArepresentation.png)

## HA Network Setup Representation

![custom](images/networkrepresentation.png)
