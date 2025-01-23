## Version 1.3.3-build-11 (2025-01-23)

[**Director 1.3.3-build-11**](https://gitlab.amzetta.com/sdwan/deployment/-/archive/1.3.3-build-11/deployment-1.3.3-build-11.zip):

- Build version : 1.3.3-build-11
- Build date : 2025-01-23

[**Installation**](/Director_Installation/Deployment/DeploymentUserGuide.md)

- **Update options**
   - From 1.3.3-x
   - From 1.3.2-x
   - From 1.3.1-x
   - From 1.3.0-x
   - Update from 1.2.x version is not supported in this release.

[**Configuration**](/Director_Installation/Deployment/DeploymentUserGuide.md)

[**FSD**](/Director_FSD/)

**Periodic Maintenance**

**New Features/Changes**

**Bugs Fixed**
 - 38366, 38741, 33933, 38762, 38357, 37208, 38182, 38642, 38509, 38712, 38675.

**Known Issues**

- While Updating from 1.3.0-x to new deployment. Minio files need to manually backup and uploaded after updating to new deployment version.
- On deployment update there might be duplicate tunnel server entry in tenant's page.
- ELK Configuration Backup & Restore doesn't have FTP support.
- ELK Data Backup & Restore supports only S3(AWS/Minio).
- Selected WAN interface will be shown as empty in balancing rule for SAAS and branch breakout. 
- Updating firmware url on existing will not reflect the new, url, need to delete and add the firmware url. 

**Limitations**

- Firmware support 
  Starting 1.3.2 director HTTPS is enabled by default and HTTP port will be blocked in future. In version 1.3.2 is enabled as existing firmware need HTTP to update the firmware, so after updating the firmware HTTP port should be blocked manually. 

- Feature: Automatic group creation based on region and model number
  - Group will be created only for new onboarding.
  - To create a group based on model number metadate needs to be updated (A fresh import of metadate or edit the existing metadata and save it).
  - Backup configuration in the deployment CLI for performing (Failover/Failback - backup and restore, on-demand) should be same as configured  in msp UI.


## Version 1.3.3-RC1 (2025-01-09)

[**Director 1.3.3-RC1**](https://gitlab.amzetta.com/sdwan/deployment/-/archive/1.3.3-RC1/deployment-1.3.3-RC1.zip):

- Build version : 1.3.3-RC1
- Build date : 2025-01-10

[**Installation**](/Director_Installation/Deployment/DeploymentUserGuide.md)

- **Update options**
   - From 1.3.2-x
   - From 1.3.1-x
   - From 1.3.0-x
   - Update from 1.2.x version is not supported in this release.

[**Configuration**](/Director_Installation/Deployment/DeploymentUserGuide.md)

[**FSD**](/Director_FSD/)

**Periodic Maintenance**

**New Features/Changes**
  - Enabled/Disable Logs through WAN interface
  - Show the WAN interface where Management tunnel is established along with netflow log status. 
  - IPv6 - Port forwarding, DDOS, DNS Lookup, Speed test support
  - Option to import excel file (csv file) on DNS local zone and filtering on ip allow list page , ip block list page for import ip allow list and block list
  - Firmware update refinement - Hidden feature to update firmware even when device status is unknown. 
  - Added option to enable/disable cross link failover on site to site tunnel page.
  - S3 support for debug dump.
  - Periodical Disaster Backup:
    - Added the alerting indices along with security config in the elastic-dump backup.
  - Dashboard Implementation:
    - WAN Fault/Recovered logs , Tunnel Fault/Recovered Logs  in the Statistics page for Edge Controller logs .
    - Categorizing the Data , Packets interface data as WAN, LAN and Tunnels (updated the same for Interface report)
  - Backup/Restore enhancement - Added logs/and email alerts as required. 

**Bugs Fixed**
 - 37476, 29909, 28456, 32169, 30493, 29322, 37617, 37578, 37566, 35086, 30138, 37632, 37406, 37512, 36726, 29611, 37610, 37116, 37636, 32841, 35781, 35824, 34145, 32868, 34148, 37212, 32945, 34144, 37581, 37583, 37115, 37166, 34829, 36990, 37312, 35138, 37257, 37241, 37304, 37256, 26305, 35261, 35262, 37459, 37464, 35141, 37247, 37396, 37200, 27362, 37513, 37514, 37484, 37409, 36449, 37411, 37338, 37332, 37263, 35150, 37627, 37820, 29909, 37671, 37748, 35346, 34721, 34774, 37707, 37419, 37804, 37862, 25070, 37705, 37737, 37722, 37706, 37186, 37751, 37725, 36445, 36183, 34791, 37162, 37043, 36749, 37666, 37710, 37932, 37923, 37674, 38005, 38006, 37389, 37945, 28866, 33933, 35081, 37022, 36935, 35206, 34434, 38065, 37990, 35260, 37994, 22815, 36162, 38232, 38207, 38201, 38198, 38196, 38185, 37996, 37970, 37971, 37623, 36309, 37929, 37956, 37926, 37928, 37938, 37940, 37961, 37943, 37799, 37775, 37797, 37447, 38231, 37995, 38398, 38416, 37405, 38122, 38273, 38382, 38409, 38371, 38477, 38449, 38339, 38448, 38527, 38496, 38523, 38541, 38495, 38533, 38509, 38354, 38470, 38351, 38234, 38384, 38355, 38347, 38356, 37925, 38638.



**Known Issues**

- While Updating from 1.3.0-x to new deployment. Minio files need to manually backup and uploaded after updating to new deployment version.
- On deployment update there might be duplicate tunnel server entry in tenant's page.
- ELK Configuration Backup & Restore doesn't have FTP support.
- ELK Data Backup & Restore supports only S3(AWS/Minio).
- Selected WAN interface will be shown as empty in balancing rule for SAAS and branch breakout. 
 - Updating firmware url on existing will not reflect the new, url, need to delete and add the firmware url. 

**Limitations**

- Firmware support 
  Starting 1.3.2 director HTTPS is enabled by default and HTTP port will be blocked in future. In version 1.3.2 is enabled as existing firmware need HTTP to update the firmware, so after updating the firmware HTTP port should be blocked manually. 

- Feature: Automatic group creation based on region and model number
  - Group will be created only for new onboarding.
  - To create a group based on model number metadate needs to be updated (A fresh import of metadate or edit the existing metadata and save it).
  - Backup configuration in the deployment CLI for performing (Failover/Failback - backup and restore, on-demand) should be same as configured  in msp UI.


## Version 1.3.2-RC1 (2024-08-19)

[**Director 1.3.2-RC1**](https://172.16.120.65/sdwan/deployment/-/archive/1.3.2-RC1/deployment-1.3.2-RC1.zip):

- Build version : 1.3.2-RC1
- Build date : 2024-08-19

[**Installation**](/Director_Installation/Deployment/DeploymentUserGuide.md)

- **Update options**
   - From 1.3.1-x
   - From 1.3.0-x
   - Update from 1.2.x version is not supported in this release.

[**Configuration**](/Director_Installation/Deployment/DeploymentUserGuide.md)

[**FSD**](/Director_FSD/)

**Periodic Maintenance**

**New Features/Changes**
- Added cluster monitoring for node, link, service failure etc. 
- Configuration option to specify disk size and swap memory size. 
- Make use of the configuration used during installation for restore. 
- Now the CA certificate used for signing the nginx certificate is sent to CPE during the onboarding.
- Regenerate the existing management tunnel certificate to extend the validity.
- Option to disable auto update of firmware. 
- Credentials are encrypted and stored in deployed system.
- Added Analytics schedule backup and restore logs icon in the schedule page and dashboard under "System metrics" as Analytics Backup Logs
- Delete Analytics data when Tenant is deleted. 
- Implementation of storage alerting for Director Host and Analytics storage when the specified threshold reaches, alert will be generated at an interval of 1 hour.
  - Alert threshold :
    - Warning Alert when usage percentage between be (70% - 84%)
    - Critical Alert  when usage percentage reached 85% and above
- Brand/Logo customization. 
- IPV4/6 DCHP relay
- WiFi - Multiple SSID support. 
- Add/Delete Private APN. 
- DSN Stub zone UI
- Cloud concentrator server monitor configuration management UI. 
- Connection based balancing when tunnels are used as Netbalancer gateways. 
- IPSec logging enable/disable. 
- Refined Copyright message and option to disable edit log for tenants. 
- Option to edit/delete SMTP configuration. 
- Netbalancer breakout for tunnel. 
- Configure Retention period for Analytics data. 
- Remove Edge controllers refined. 
- Global Apps refinement - send logs to ELK on api request and only send logs on change. 


**Bugs Fixed**
- 36176, 36200, 35823, 36144, 36085, 36207, 36306, 36179, 36129, 35964, 36447, 36179, 36162, 36320, 36030, 36471, 34920, 34921, 36530, 36536, 33281, 36550, 36178, 36196, 36074, 36357, 36417, 36358, 36357, 35999, 35672, 36261, 36557, 33168, 36074, 30886, 35953, 35083, 35093, 35095, 36572, 35968, 35090, 36645, 36508, 35137, 36731, 36614, 36464, 36465, 36609, 36607, 36608, 36611, 36679, 30886, 36060, 36843, 36060, 36796, 36808, 33894, 33953, 36916, 36801, 36741, 36733, 36953, 366022, 35199, 36786, 35273, 32478, 30965, 36742, 35203, 32035, 34847, 34208, 33114, 36688, 31645, 35746, 36220, 36959


**Known Issues**

- While Updating from 1.3.0-x to new deployment. Minio files need to manually backup and uploaded after updating to new deployment version.
- On deplyment update there might be duplicate tunnel server entry in tenant's page.
- ELK Configuration Backup & Restore doesn't have FTP support.
- ELK Data Backup & Restore supports only S3(AWS/Minio).
- Audit Log for MSP 

**Limitations**

- Firmware support 
  Starting 1.3.2 director HTTPS is enabled by default and HTTP port will be blocked in future. In version 1.3.2 is enabled as existing firmware need HTTP to update the firmware, so after updating the firmware HTTP port should be blocked manually. 

- Feature: Automatic group creation based on region and model number
  - Group will be created only for new onboarding.
  - To create a group based on model number metadate needs to be updated (A fresh import of metadate or edit the existing metadata and save it).
  

#### Updating from 1.3.1 to 1.3.2. 

 - Update director to 1.3.2
	- Standalone Setup
		```
		./setup.sh standalone update elk openvpn zid clustersvc externalsvc msp tenant nginx
		```
 
	- Cluster Setup
		```
		./setup.sh update elk openvpn zid clustersvc externalsvc msp tenant nginx
		```
 - Extend certificate validity. 
	- To extend the management tunnel certificate validity. we need to run following command
		- Standalone Setup
			```
			./setup.sh standalone regenerate
			```
		- Cluster Setup
			```
			./setup.sh regenerate
			```
 - Update management url(https), trusted CA in provisioning  server 
 - Update firmware from director UI 
 - Verify the CPE onboards with https URL and events are receivied

Note : Firmware version 1.2-01.1029 or earlier does not support HTTPS

**DC-DR Migration**

- Before running the dc dr migration please configure the backup setting from msp UI
- To migrate DC to DR
```
DC
    ./setup.sh <standalone> dc-to-dr
    It will backup the DC server and change the deployment state to passive in mongo
DR
    ./setup.sh <standalone> dc-to-dr
    It will do restore in DR server, run the migrate script automatically and change the deployment state to active
```
- To migrate DR to DC
```
DR
    ./setup.sh <standalone> dr-to-dc
    It will backup the DC server and change the deployment state to passive in mongo
DC
    ./setup.sh <standalone> dr-to-dc
    It will do restore in DR server, run ther migrate script automatically and change the deployment state to active
```
- Change the director url in provisioning server and re-onboard the device manually to the respective directors.
- **Note:** Configure AZURE, AWS(S3) credentials before proceeding migration


## Version 1.3.1-RC1 (2024-05-21)

[**Director 1.3.1-RC1**](https://172.16.120.65/sdwan/deployment/-/archive/1.3.1-RC1/deployment-1.3.1-RC1.zip):

- Build version : 1.3.1-RC1
- Build date : 2024-05-21

[**Installation**](/Director_Installation/Deployment/DeploymentUserGuide.md)

- **Update options**
   - From 1.3.0-x
   - Update from 1.2.x version is not supported in this release.

[**Configuration**](/Director_Installation/Deployment/DeploymentUserGuide.md)

[**FSD**](/Director_FSD/)

**Periodic Maintenance**

**New Features/Changes**
- Site to mobile VPN support with LDAP and OAuth
- SSL VPN tunnel support added. 
- Added external disk support for storing ELK data
- Director DC/DR failover/fail back with backup and restore. 
- DC/DR CPE Site failover and automatic switchover. 
- Scheduled based Continuous backup and restore of analytics data using Azure/AWS S3/Minio backup server
- Postgres operator for Director HA
- Handle download image failure during deployment. 
- Vagrant Image with Azure and AWS CLI and mongodb
- DNS Auth zone UI
- List connected client in SSL VPN
- Multiple WAN Interface support
- Multiple External IP support
- Manage tunnel server IPs from MSP and Tenant
- Ram configuration VM's can be mentioned in the master.yml, this is needed to create the required RAM for elk VM (Default ELK configuration is given in master.yml)

**Bugs Fixed**

- 35944, 35822, 35770, 32323, 35439, 35315, 34884, 35772, 35858, 34360, 35683, 35017, 35828, 35903, 35888, 35687, 34919, 35369, 35401, 34434, 35473, 35472, 34833, 35311, 34921, 35422, 34393, 34920, 35275, 35542, 35544, 35465, 35397.


**Known Issues**

- While Updating from 1.3.0-x to new deployment. Minio files need to manually backup and uploaded after updating to new deployment version.
- On deplyment update there might be duplicate tunnel server entry in tenant's page.
- ELK Configuration Backup & Restore doesn't have FTP support.
- ELK Data Backup & Restore supports only Azure, S3(AWS/Minio).

**Limitations**

- Feature: Automatic group creation based on region and model number
  - Group will be created only for new onboarding.
  - To create a group based on model number metadate needs to be updated (A fresh import of metadate or edit the existing metadata and save it).
  
**Update Command**

- Standalone Setup Without Multiple WAN 

```
./setup.sh standalone update nginx elk openvpn zid clustersvc externalsvc msp tenant
```

- Standalone Setup With Multiple WAN
```
./setup.sh standalone update nginx hostinterface elk openvpn zid clustersvc externalsvc msp tenant
```

- Cluster Setup With or Without Multiple WAN
```
./setup.sh update nginx hostinterface elk openvpn zid clustersvc externalsvc msp tenant
```

**DC-DR Migration**

- Before running the dc dr migration please configure the backup setting from msp UI
- To migrate DC to DR
```
DC
    ./setup.sh <standalone> dc-to-dr
    It will backup the DC server and change the deployment state to passive in mongo
DR
    ./setup.sh <standalone> dc-to-dr
    It will do restore in DR server, run the migrate script automatically and change the deployment state to active
```
- To migrate DR to DC
```
DR
    ./setup.sh <standalone> dr-to-dc
    It will backup the DC server and change the deployment state to passive in mongo
DC
    ./setup.sh <standalone> dr-to-dc
    It will do restore in DR server, run ther migrate script automatically and change the deployment state to active
```
- Change the director url in provisioning server and re-onboard the device manually to the respective directors.
- **Note:** Configure AZURE, AWS(S3) credentials before proceeding migration


## Version 1.3.1-build-2

[**Director 1.3.1-build-2**](https://172.16.120.65/sdwan/deployment/-/archive/1.3.1-build-2/deployment-1.3.1-build-2.zip):

- Build version : 1.3.1-build-2
- Build date : 2024-04-17

[**Installation**](/Director_Installation/Deployment/DeploymentUserGuide.md)

- **Update options**
   - From 1.3.0-build-2
   - Update from 1.2.x version is not supported in this release.

[**Configuration**](/Director_Installation/Deployment/DeploymentUserGuide.md)

[**FSD**](/Director_FSD/)

**Periodic Maintenance**

**New Features/Changes**
- Multiple WAN Interface support
- Multiple External IP support
- Site switch over script
- Manage tunnel server IPs from MSP and Tenant
- Ram configuration VM's can be mentioned in the master.yml, this is needed to create the required RAM for elk VM (Default ELK configuration is given in master.yml)
- Scheduled based Continuous backup and restore of analytics data using minio backup server

**Bugs Fixed**

- 35401, 34434, 35473, 35472, 34833, 35311, 34921, 35422, 34833, 34393, 34920, 35275, 35542, 35544, 35465, 35542.

**Known Issues**

- On deplyment update there might be duplicate tunnel server entry in tenant's page.
- ELK Configuration Backup & Restore doesn't have FTP support.
- ELK Data Backup & Restore supports only Minio.

**Limitations**

- Feature: Automatic group creation based on region and model number
  - Group will be created only for new onboarding.
  - To create a group based on model number metadate needs to be updated (A fresh import of metadate or edit the existing metadata and save it).
  
**Update Command**

- Without Multiple WAN

```
./setup.sh <standalone> update nginx elk openvpn zid clustersvc externalsvc msp tenant
```

- With Multiple WAN
```
./setup.sh <standalone> update nginx hostinterface elk openvpn zid clustersvc externalsvc msp tenant
```

**DC-DR Migration**

- Before running the dc dr migration please configure the backup setting from msp UI
- To migrate DC to DR
```
DC
    ./setup.sh <standalone> dc-to-dr
    It will backup the DC server and change the deployment state to passive in mongo
DR
    ./setup.sh <standalone> dc-to-dr
    It will do restore in DR server, run the migrate script automatically and change the deployment state to active
```
- To migrate DR to DC
```
DR
    ./setup.sh <standalone> dr-to-dc
    It will backup the DC server and change the deployment state to passive in mongo
DC
    ./setup.sh <standalone> dr-to-dc
    It will do restore in DR server, run ther migrate script automatically and change the deployment state to active
```
- Change the director url in provisioning server and re-onboard the device manually to the respective directors.
- **Note:** Configure AZURE, AWS(S3) credentials before proceeding migration

## Version 1.3.0-build-3

[**Director 1.3.0-build-3**](https://gitlab.amzetta.com/sdwan/deployment/-/archive/1.3.0-build-3/deployment-1.3.0-build-3.zip):

- Build version : 1.3.0-build-3
- Build date : 2024-04-17

[**Installation**](/Director_Installation/Deployment/DeploymentUserGuide.md)

- **Update options**
  - Update from 1.2.x version is not supported. Workaround is to Backup the database and restore.


[**Configuration**](/Director_Installation/Deployment/DeploymentUserGuide.md)

[**FSD**](/Director_FSD/)

**Periodic Maintenance**

**New Features**

**Bugs Fixed**

- Fixed migrate external ip script to update ec's tunnel server ip.

**Known Issues**

- On executing migrate script there might be a duplicate duplicate tunnel server entry in tenant's page.

**Limitations**

- Feature: Automatic group creation based on region and model number
  - Group will be created only for new onboarding.
  - To create a group based on model number metadate needs to be updated (A fresh import of metadate or edit the existing metadata and save it).

## Version 1.2.3-build-1

[**Director 1.3.0-build-2**](https://gitlab.amzetta.com/sdwan/deployment/-/archive/1.2.3-build-1/deployment-1.2.3-build-1.zip):

- Build version : 1.2.3-build-1
- Build date : 2024-04-02

[**Installation**](/Director_Installation/Deployment/DeploymentUserGuide.md)

- **Update options**
   - From 1.2.2-build-x

[**Configuration**](/Director_Installation/Deployment/DeploymentUserGuide.md)

[**FSD**](/Director_FSD/)

**Periodic Maintenance**

**New Features/Changes**
- DC Concentrator Multi pair support.
- Update the DC concentrator IP to branches that were down during site switch over.

**Bugs Fixed**

- None.

**Known Issues**

**Limitations**

- Feature: Automatic group creation based on region and model number
  - Group will be created only for new onboarding.
  - To create a group based on model number metadate needs to be updated (A fresh import of metadate or edit the existing metadata and save it).


## Version 1.3.0-build-2

[**Director 1.3.0-build-2**](https://gitlab.amzetta.com/sdwan/deployment/-/archive/1.3.0-build-2/deployment-1.3.0-build-2.zip):

- Build version : 1.3.0-build-3
- Build date : 2024-03-22

[**Installation**](/Director_Installation/Deployment/DeploymentUserGuide.md)

- **Update options**
  - Update from 1.2.x version is not supported. Workaround is to Backup the  database and restore.

[**Configuration**](/Director_Installation/Deployment/DeploymentUserGuide.md)

[**FSD**](/Director_FSD/)

**Periodic Maintenance**

**New Features/Changes**

- Added Postgres Operator
- Start/Stop port forwarding on Keepalived status change.
- Support for Backup/Restore on cloud AWS/Azure.
- Support for Site switch over.
- Support for Minio external disk.
- Customizable ELK Memory.

**Bugs Fixed**

- None.

**Known Issues**

**Limitations**

- Feature: Automatic group creation based on region and model number
  - Group will be created only for new onboarding.
  - To create a group based on model number metadate needs to be updated (A fresh import of metadate or edit the existing metadata and save it).

## Version 1.2.2-build-3

[**Director 1.2.2-build-2**](https://gitlab.amzetta.com/sdwan/deployment/-/archive/1.2.2-build-3/deployment-1.2.2-build-3.zip):

- Build version : 1.2.2-build-3
- Build date : 2024-03-19

[**Installation**](/Director_Installation/Deployment/DeploymentUserGuide.md)

- **Update options**
  - From 1.2.1-build-1   

  - From 1.2.2-build-1   

  - From 1.2.2-build-2   


[**Configuration**](/Director_Installation/Deployment/DeploymentUserGuide.md)

[**FSD**](/Director_FSD/)

**Periodic Maintenance**

**New Features**

- Port number is optional in Global application.
- Prompt credentials during deployment.
- Changed default minio password.
- Added a hidden url to encode/decode the configuration yaml file.

**Bugs Fixed**

- 29903, 34789, 34726, 35056, 35084, 35195, 35133.

**Known Issues**

**Limitations**

- Feature: Automatic group creation based on region and model number
  - Group will be created only for new onboarding.
  - To create a group based on model number metadate needs to be updated (A fresh import of metadate or edit the existing metadata and save it).

---

## Version 1.2.2-build-2

[**Director 1.2.2-build-2**](https://gitlab.amzetta.com/sdwan/deployment/-/archive/1.2.2-build-2/deployment-1.2.2-build-2.zip):

- Build version : 1.2.2-build-2
- Build date : 2024-02-12

[**Installation**](/Director_Installation/Deployment/DeploymentUserGuide.md)

- **Update options**
  - From 1.2.1-build-1   

  - From 1.2.2-build-1   


[**Configuration**](/Director_Installation/Deployment/DeploymentUserGuide.md)

[**FSD**](/Director_FSD/)

**Periodic Maintenance**

**New Features**

- Display CPE name, location name, region and location as map pop up.
- Create group with regex pattern.
- Add UI option to set MUT size for WAN and tunnel interface.
- Send alert to Admin users once the device is powered on and connected to director.
- List the CPE status/progress in UI.
- Add meta data to import/export configuration.
- Create the separate groups based on the region, model number automatically, after onboarding the edge-controller.
- Add regex condition to update firmware based on version from UI.
- Display CPE CPU manufacture brand, speed details in info page.
- Certificate revoke lable change.
- Optimized indices for Netflow and syslog datasets to minimize ELK data volume.
- Updated dashboards and alerting monitor messages based on these optimizations.

**Bugs Fixed**

- 34625, 34600, 34588, 34591, 34589, 34637, 34259

**Known Issues**

**Limitations**

- Feature: Automatic group creation based on region and model number
  - Group will be created only for new onboarding.
  - To create a group based on model number metadate needs to be updated (A fresh import of metadate or edit the existing metadata and save it).

---

## Version 1.1.2-patch-1

[**Director 1.1.2-patch-1**](https://gitlab.amzetta.com/sdwan/deployment/-/archive/1.1.2-patch-1/deployment-1.1.2-patch-1.zip):

- Build version : 1.1.2-patch-1
- Build date : 2024-02-08

[**Installation**](/Director_Installation/Deployment/DeploymentUserGuide.md)

[**Configuration**](/Director_Installation/Deployment/DeploymentUserGuide.md)

[**FSD**](/Director_FSD/)

**Periodic Maintenance**

**New Features**

- NIL.

**Bugs Fixed**

- 34359 (Updated vagrant version from 2.3.4 to 2.4.0-1. As vagrant-libvirt version 0.7.0 a plugin used with vagrant 2.3.4 version is deleted from public repository and not available anymore.)

**Known Issues**

**Limitations**

---

## Version 1.2.2-build-1

[**Director 1.2.2-build-1**](https://gitlab.amzetta.com/sdwan/deployment/-/archive/1.2.2-build-1/deployment-1.2.2-build-1.zip):

- Build version : 1.2.2-build-1
- Build date : 2024-01-24

[**Installation**](/Director_Installation/Deployment/DeploymentUserGuide.md)

[**Configuration**](/Director_Installation/Deployment/DeploymentUserGuide.md)

[**FSD**](/Director_FSD/)

**Periodic Maintenance**

**New Features**

- Firmware version comparsion using regex.
- Support for new heart beat status from firmware.

**Bugs Fixed**

- 34134, 34246, 34221, 34038, 34268, 33107, 34047, 29934, 32394, 34485, 33933, 34363, 32619, 34143, 34164, 34147, 34454, 34339, 31017, 34248, 34399

**Known Issues**

**Limitations**

---

## Version 1.2.1

- Features
  - Import/Export configuraiton.
  - Renew Cetrificate from UI.
  - DC monitor refined.
- Bugs Fixed
  - 33164, 34072, 33951, 33868, 34048

---

```
 ./setup.sh standalone update elk clustersvc externalsvc nginx tenant
```
