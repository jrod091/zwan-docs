# SDWAN - zWAN

### BUILD SYSTEM AND FIRMWARE IMAGE LOCATION

   **BUIULD MACHINE IP:** 10.100.186.71
   
   **CREDENTIALS:** username: qarelease | password: password
   
   **PATH:** /home/qarelease/1.2-04.1036
   
   **BUILD VERSION:** 1.2-04.1036
   
   **BUILD DATE:** 09/01/2025 [ Thursday ]
   
### FILENAME (FRESH INSTALLATION)

#AMZ7622 : build-amz7622-1.2-04.1036-Jan08-2025-160908.bin

#BPIR64  : build-bpir64-1.2-04.1036-Jan08-2025-160817.bin

#BPI-R3  : build-bpi-r3-1.2-04.1036-Jan08-2025-161306.bin

#CWAN801 : build-cwan801-1.2-04.1036-Jan08-2025-160817.bin

#x86    : cpe-base-1.2-04.1036-5749.qcow2.xz

### FILENAME (FULL PATCH UPDATE)

#PATCH-AMZ7622 :  patch-amz7622-1.2-04.1036-Jan09-2025-102209.bin

#PATCH-BPIR64  :  patch-bpir64-1.2-04.1036-Jan09-2025-102158.bin

#PATCH-BPI-R3  :  patch-bpi-r3-1.2-04.1036-Jan09-2025-102233.bin

#PATCH-CWAN801 :  patch-cwan801-1.2-04.1036-Jan09-2025-102221.bin

#PATCH-x86     :  cpe-fw-package-1.2-04.1036-Jan09-2025-102325.bin
   
### VCPE DEPLOYMENT TAG

   **https://gitlab.amzetta.com/sdwan/vcpe-deployment**
   

### CONFIGURATION


### FSD

   **https://gitlab.amzetta.com/sdwan/zwan-doc/-/tree/master/CPE_FSD**

### PERIODIC MAINTENANCE


### NEW FEATURE ADDITION

    
### BUG FIXES 

| #     | Project       | Build Version                   | Subject                                                                                                                                                                                    | Author          | Assignee                   | Priority | Status   | Create Date | Created             | Target version      | Due date            | Updated    | Start date | Parent task                 | Components             | Tracker                   | Resolution | Closed Date | % Done | Private |
| ----- | ------------- | ------------------------------- | ------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------ | --------------- | -------------------------- | -------- | -------- | ----------- | ------------------- | ------------------- | ------------------- | ---------- | ---------- | --------------------------- | ---------------------- | ------------------------- | ---------- | ----------- | ------ | ------- |
| 38658 | Networking-QA | 1.3.3-build-7 / 1.2-04.1035     | After disabling and enabling the VLAN WAN interface, the default route is not being re-added for the WAN VLAN                                                                              | Somasundaram R  | Vijayarankan M V Venugopal | Sev 2    | New      | ########    | ########            |                     |                     | ########   |            | 29869                       |                        | Bug                       |            |             | 0      | No      |
| 38653 | Networking-QA | 1.3.3-build-7 / 1.2-04.1035     | When vLAN for WAN is configured, Then NAT should be enabled automatically for "WAN0x VLAN xx"                                                                                              | Somasundaram R  | Sharon Enoch               | Sev 3    | New      | ########    | ########            |                     |                     | ########   |            | 29869                       |                        | Bug                       |            |             | 0      | No      |
| 38566 | Networking-QA | 1.3.3-build-6 / 1.2-04.1035     |  LAN-to-LAN Communication Fails After CPE Reboot Due to SSL VPN Route Removed and in NB Tunnel and IB uptime and down time shows as N/A                                                    | Mohan Y         | Sharon Enoch               | Sev 2    | Resolved | 12/31/2024  | 12/31/2024 05:59 PM | ########            |                     | 29869      |            | Bug                         | Change - Module Update | 0                         | No         |
| 38549 | Networking-QA | build1.3.3-build-6, 1.2-04.1035 | LTE LED is not getting blinked for all Active State                                                                                                                                        | Anitha B        | Sivambigai M               | Sev 2    | Resolved | 12/30/2024  | 12/30/2024 04:16 PM | 12/30/2024 06:59 PM | 29869               |            | Bug        | Change - Module Update      | 100                    | No                        |
| 38522 | Networking-QA | 1.3.3-build-6/ 1.2-04.1035      |  IPSEC Tunnel IP Ping between DC & Branch  is getting failed in UI under  Utilties Page                                                                                                    | Anitha B        | Sharon Enoch               | Sev 2    | Resolved | 12/26/2024  | 12/26/2024 05:38 PM | ########            |                     | 29869      |            | Bug                         | Change - Module Update | 0                         | No         |
| 38521 | Networking-QA | 1.3.3-build-6 / 1.2-04.1035     | Despite MGMTVPN Being Established via ETH WAN00, Tunnel Connected Icon Incorrectly Displays on SWAN Interface (IB Down for SWAN Interface, Netflow Disabled on WAN00, and Enabled on SWAN) | Somasundaram R  | Srikumar Subramanian       | Sev 2    | Resolved | 12/26/2024  | 12/26/2024 04:38 PM | 12/30/2024 04:56 PM | 29869               |            | Bug        | No Change - Issue Duplicate | 0                      | No                        |
| 38510 | Networking-QA | 1.3.3-build-6 / 1.2-04.1035     | Connected Client Hostname and IP Address Missing in Wi-Fi Page                                                                                                                             | Saravanakumar E | Sivakumar M                | Sev 3    | Resolved | 12/24/2024  | 12/24/2024 05:36 PM | 12/28/2024          | 12/26/2024 01:23 PM | 12/26/2024 | 29869      |                             | Bug                    | Fixed - Defects (Generic) | 100        | No          |
| 38508 | Networking-QA | 1.3.3-build-5 /1.2-04.1035-dev  | List of issues in the MGMT ISP Failover and Log Disable/Enable Dev validation                                                                                                              | Saravanakumar E | Vijayarankan M V Venugopal | Sev 4    | Resolved | 12/24/2024  | 12/24/2024 03:34 PM | 12/26/2024 06:11 PM | 29869               |            | Bug        |                             |                        | 0                         | No         |
| 38506 | Networking-QA |  1.3.3-build-6 / 1.2-04.1035    | IPSEC Tunnel Local IP Not Updated After LTE IP Change on BPI-R64 hardware                                                                                                                  | Mohan Y         | Sharon Enoch               | Sev 2    | Resolved | 12/24/2024  | 12/24/2024 02:48 PM | 12/31/2024 02:55 AM | 29869               |            | Bug        | Change - Module Update      | 0                      | No                        |
| 38505 | Networking-QA | 1.3.3-build-6 / 1.2-04.1035     | In IB over DC IPSEC Tunnel  without path affinity with DNs forwarding- After removing and reconnecting the WAN00 cable in Branch CPE, it's respective IB still in Faulty state             | Lavanya  K      | Sharon Enoch               | Sev 2    | Resolved | 12/24/2024  | 12/24/2024 01:04 PM | ########            |                     | 29869      |            | Bug                         | Change - Module Update | 0                         | No         |
                                   

### KNOWN ISSUES

### LIMITATIONS

### zWAN Hardware Requirements

**Below represents the zWAN Hardware Requirements for EC**

| | | | | |
|-|-|-|-|-|
|**Sl.No**|**Edge Controller Hardware Requirement**|**SOHO/Small Branch**|**SMB/Medium Size Branch**|**DC – Concentrator(each Concentrator supports 256  Branches)**
|1|F/W: CPE 1.2.10xx is QA tested (follow the release notes)F/W: CPE 1.3.000x is in QA)|**EC on ARM H/W:** AMZ z25 (2 core, 1 GB, 4G, 5G, Wifi, 6xGigE) – **NO IPS/IDS, NO DNS Filter**|**EC on X86 h/w:** Kettop Mi10610L8 (i7, 12 cores, 8GB, 4G, Wifi, 8xGigE) – **with IPS/IDS and DNS filter**|**EC on X86 h/w:** Kettop Mi3958 (Atom 16 cores, 8GB, Wifi, 5xGigE, 4x10Gbps) – with IPS/IDS and DNS filter|
| | | **EC on X86 h/w:** Kettop Mi4125L5 (Celeron 4 cores, 4GB, 4G, Wifi, 5xGigE)  - **IPS/IDS or DNS Filter, not both**|**EC on X86 h/w:** Kettop Mi3758RL9 (Atom 8 cores, 8GB, 5G, Wifi, 5xGigE, 4x10Gbps) – **with IPS/IDS and DNS filter**|**vCPE on KVM/HyperV/ESXi:** Each vCPE require (6cores, 4GB, 1xGigE for each WAN/LAN) – without IPS/IDS and DNS filter   KVM deployment - Tested  HyperV/ESXi – not fully verified|
| | | **vEC on Laptop:** Laptop with (4 cores, 4GB RAM, 32GB SSD, Windows 10 or above, 64bit edition, Windows Profession/Enterprise/Education) – **NO IPS/IDS, NO DNS Filter**| | **vCPE on KVM/HyperV/ESXi:** Each vCPE require (8cores, 8GB, 1xGigE for each WAN/LAN) – **with IPS/IDS and DNS filter**|
| | | | | **EC-HA on DC**– Double the above hardware requirement for Active/Passive DC-HA|
| | | | | **EC as Cloud Gateway** – not fully verified|


### CPE INSTALLATION

   **https://gitlab.amzetta.com/sdwan/zwan-doc/-/tree/master/CPE_Installation%2FInstallation**

### CPE LED CONFIGURATION    

   **https://gitlab.amzetta.com/sdwan/zwan-doc/-/blob/master/CPE_FSD/LEDS/LED_AMZ7622.md**
