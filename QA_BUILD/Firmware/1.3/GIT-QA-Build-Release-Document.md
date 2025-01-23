# SDWAN - zWAN

### BUILD SYSTEM AND FIRMWARE IMAGE LOCATION

   **BUIULD MACHINE IP:** 10.100.186.9
   
   **CREDENTIALS:** username: qarelease | password: password
   
   **PATH:** /home/qarelease/1.3-04.1013
   
   **BUILD VERSION:** 1.3-04.1013
   
   **BUILD DATE:** 16/12/2024 [ Monday ]
   
### FILENAME (FRESH INSTALLATION)

#AMZ7622    -   **Filename:**  build-amz7622-1.3-04.1013-Dec16-2024-183052.bin

#BPIR64     -   **Filename:**  build-bpir64-1.3-04.1013-Dec16-2024-182921.bin

#BPI-R3     -   **Filename:**  image-bpi-r3-1.3-04.1013-Dec16-2024-184240_emmc.img.gz

#BPI-R4		-   **Filename:**  image-bpi-r4-1.3-04.1013-Dec16-2024-185547_emmc.img.gz

#CWAN801    -   **Filename:**  build-cwan801-1.3-04.1013-Dec16-2024-182921.bin

#x86        -   **Filename:**  cpe-base-1.3-04.1013-6468.qcow2.xz

### FILENAME (FULL PATCH UPDATE)

#PATCH-AMZ7622  -   **Filename:**  patch-amz7622-1.3-04.1013-Dec16-2024-185923.bin

#PATCH-BPIR64   -   **Filename:**  patch-bpir64-1.3-04.1013-Dec16-2024-185905.bin

#PATCH-BPI-R3   -   **Filename:**  patch-bpi-r3-1.3-04.1013-Dec16-2024-190015.bin

#PATCH-BPI-R4   -   **Filename:**  patch-bpi-r4-1.3-04.1013-Dec16-2024-190100.bin

#CWAN801        -   **Filename:**  patch-cwan801-1.3-04.1013-Dec16-2024-185947.bin

#PATCH-x86      -   **Filename:**  cpe-fw-package-1.3-04.1013-Dec16-2024-190339.bin


### VCPE DEPLOYMENT TAG

   **https://gitlab.amzetta.com/sdwan/vcpe-deployment**
   
### INSTALLATION TAG

   **https://gitlab.amzetta.com/sdwan/zwan-doc/-/tree/master/CPE_Installation%2FInstallation**


### CONFIGURATION


### FSD

   **https://gitlab.amzetta.com/sdwan/zwan-doc/-/tree/master/CPE_FSD**

### PERIODIC MAINTENANCE


### NEW FEATURE ADDITION

-   Migration Support: Added migration capability from versions 1.2-03.1034 to 1.3-04.1013.

### BUG FIXES 

| #     | Project               | Build Version                           | Subject                                                                                                                                                                                       | Author                | Assignee                   | Priority | Status   | Create Date | Created             | Target version      | Due date            | Updated    | Start date | Parent task               | Components | Tracker                   | Resolution             | Closed Date | % Done | Private |
| ----- | --------------------- | --------------------------------------- | --------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- | --------------------- | -------------------------- | -------- | -------- | ----------- | ------------------- | ------------------- | ------------------- | ---------- | ---------- | ------------------------- | ---------- | ------------------------- | ---------------------- | ----------- | ------ | ------- |
| 38373 | Networking-QA         | 1.3.3-build-4 /1.3-03.1012              | Previous configuration of BOND00 & VLAN  still exist in Raw Config file in OSPF after new configuration                                                                                       | Anitha B              | Sharon Enoch               | Sev 3    | Resolved | ########    | ########            |                     |                     | ########   |            | 33118                     |            | Bug                       | Fixed - Module Update  | 0           | No     |
| 38216 | Networking-QA         | 1.3.3-build-4 / 1.3-03.1012             | Geo-Fence : Only Ethernet related MAC address needs to be allowed for both discover & manual entry of MAC Address &,wifi (AP ) mac address should not allow for both discover & manual Entry  | Anitha B              | Vijayarankan M V Venugopal | Sev 2    | Resolved | 11/28/2024  | 11/28/2024 01:26 PM | ########            |                     | 33118      |            | Feature                   |            |                           | 100                    | No          |
| 38202 | SDWAN                 |                                         | BPI-R4 ledconfig and quectel-CM as lte manager & restore last good configuration                                                                                                              | Sivambigai M          |                            | Sev 4    | Resolved | 11/26/2024  | 11/26/2024 05:22 PM | ########            |                     |            |            | Feature                   |            |                           | 0                      | No          |
| 38184 | Networking-QA         | 1.3.3-build-4 /1.3-03.1012              | In BPIR4 , Incorrect Client Subnet Displayed in WiFi AP Mode Connected Clients List When connect the Virtual SSID                                                                             | Saravanakumar E       | Sivakumar M                | Sev 3    | Resolved | 11/25/2024  | 11/25/2024 04:24 PM | 12/18/2024          | ########            | ########   | 33118      |                           | Bug        | Fixed - Defects (Generic) | 100                    | No          |
| 38183 | Networking-QA         | 1.3.3-build-4 /1.3-03.1012              | On BPIR4 with MediaTek Asia/RF (MT7915E) chip , cross-LAN communication is observed between multiple Virtual SSIDs without enabling the LAN-to-LAN routing                                    | Saravanakumar E       | Sivakumar M                | Sev 3    | Resolved | 11/25/2024  | 11/25/2024 03:52 PM | ########            | ########            | ########   | 33118      |                           | Sighting   | Fixed - Defects (Generic) | 100                    | No          |
| 38168 | Networking-QA         | 1.3.3-build-4 /1.3-03.1012              | Incorrect APN Retained After SIM Swap Between 5G and 4G LTE Slots in BPIR4 CPE with Firmware 1.3-03.1012                                                                                      | Saravanakumar E       | Vijayarankan M V Venugopal | Sev 2    | Resolved | 11/22/2024  | 11/22/2024 07:03 PM | ########            |                     | 33118      |            | Bug                       |            | ########                  | 100                    | No          |
| 38154 | Networking-QA         | 1.3.3-build-4 / 1.3-03.1012             | Firewall add rule QOS error in fresh system because of captive portal support                                                                                                                 | Vinayagamoorthy  Mani | Gokul raj                  | Sev 2    | Resolved | 11/21/2024  | 11/21/2024 04:55 PM | 11/28/2024          | 11/26/2024 07:14 PM | 11/22/2024 | 33118      |                           | Bug        |                           |                        | 100         | No     |
| 38114 | Networking-QA         | FW 1.3-03.1012 / Director 1.3.3-Build-3 | Tegernsee service is keep on restarting once the /var/log partition get full                                                                                                                  | Dhanesh  Rajathurai   | Sharon Enoch               | Sev 2    | Resolved | 11/19/2024  | 11/20/2024 07:38 AM | 11/22/2024 04:10 AM | 33118               |            | Bug        | Change - Module Update    | 0          | No                        |
| 38113 | Networking-QA         | FW 1.3-03.1012 / Director 1.3.3-Build-3 | Deleting IPSEC tunnels from UI is not get cleared backend in /var/register folder.                                                                                                            | Dhanesh  Rajathurai   | Sharon Enoch               | Sev 2    | Resolved | 11/19/2024  | 11/20/2024 07:38 AM | 11/20/2024 07:51 AM | 33118               |            | Bug        | Fixed - Module Update     | 0          | No                        |
| 38111 | Networking-QA         | 1.3.3-build-4 /1.3-03.1012              | Unable to connect to SWAN00 & SWAN01 on BPIR4 when AP mode is configured with a different channel and is in an enabled state.                                                                 | Saravanakumar E       | Sivakumar M                | Sev 2    | Resolved | 11/19/2024  | 11/19/2024 07:20 PM | 11/22/2024          | 11/21/2024 11:32 AM | 11/21/2024 | 33118      |                           | Bug        | Fixed - Defects (Generic) | 11/21/2024             | 100         | No     |
| 38108 | Networking-QA         | 1.3.3-build-4 /1.3-03.1012              | The channel displayed on the client device should match the configured channel (64) on the BPIR4 CPE.                                                                                         | Saravanakumar E       | Sivakumar M                | Sev 4    | Resolved | 11/19/2024  | 11/19/2024 02:46 PM | 11/27/2024          | 11/20/2024 04:21 PM | 11/20/2024 | 33118      |                           | Bug        | Fixed - Defects (Generic) | 11/20/2024             | 100         | No     |
| 38104 | Networking-QA         | 1.3.3-build-4 /1.3-03.1012              | BPIR4 Wi-Fi AP Mode Disabled When Changing Channel Number from 124 to 128 on 5GHz for MediaTek Chip (7906)                                                                                    | Saravanakumar E       | Sivakumar M                | Sev 3    | Resolved | 11/19/2024  | 11/19/2024 12:21 PM | 11/29/2024          | 11/21/2024 11:47 AM | 11/21/2024 | 33118      |                           | Bug        | Fixed - Defects (Generic) | 100                    | No          |
| 38103 | Networking-QA         | 1.3.3-build-4 /1.3-03.1012              | BPIR4 Wi-Fi Connectivity Issue on Channels 48 and 52 (MediaTek 7906 Chipset)                                                                                                                  | Saravanakumar E       | Sivakumar M                | Sev 3    | Resolved | 11/19/2024  | 11/19/2024 12:09 PM | 11/28/2024          | 11/20/2024 05:43 PM | 11/20/2024 | 33118      |                           | Bug        | Fixed - Defects (Generic) | 11/27/2024             | 100         | No     |
| 38085 | Networking-QA         | 1.3.3-build-4 / 1.3-03.1012             |  Hostapd Service Fails When Changing WiFi Channel in WIFI Access Point Mode                                                                                                                   | Mohan Y               | Sivakumar M                | Sev 4    | Resolved | 11/18/2024  | 11/18/2024 06:46 PM | 11/22/2024          | 11/21/2024 06:11 PM | 11/21/2024 | 33118      |                           | Sighting   | Fixed - Defects (Generic) | 11/21/2024             | 100         | No     |
| 38084 | SDWAN                 |                                         | Multi hostapd enable disable each multiple ssid interface                                                                                                                                     | Sivambigai M          |                            | Sev 4    | Resolved | 11/18/2024  | 11/18/2024 06:20 PM | 11/26/2024 05:21 PM |                     | Feature    |            |                           | 0          | No                        |
| 38079 | Networking-QA         | 1.3.3-build-4 /1.3-03.1012              | In BPIR4 with MediaTek 7906 - Unable to Connect to Wi-Fi AP Mode (WLAN00- 2.5Ghz) with Channel number 3                                                                                       | Saravanakumar E       | Sivakumar M                | Sev 3    | Resolved | 11/18/2024  | 11/18/2024 12:49 PM | 11/29/2024          | 11/20/2024 04:06 PM | 11/20/2024 | 33118      |                           | Bug        | Known Issues              | 11/20/2024             | 100         | No     |
| 38069 | Customer POC Problems | 1-3.03-1012                             | shell menu default gw check                                                                                                                                                                   | Neal Levy             | Venugopal Reddy            | Sev 3    | Resolved | 11/14/2024  | 11/16/2024 01:04 AM | 11/22/2024          | 11/18/2024 07:32 AM | 11/14/2024 | 38035      |                           | Bug        |                           |                        | 100         | No     |
| 38067 | Customer POC Problems | 1-3.03-1012                             | shell menu option 11                                                                                                                                                                          | Neal Levy             | Sharon Enoch               | Sev 4    | Resolved | 11/15/2024  | 11/16/2024 01:03 AM | 11/20/2024 07:50 AM | 38035               |            | Bug        | Fixed - Module Update     | 100        | No                        |
| 38041 | Networking-QA         | 1.3.3-build-4 /1.3-03.1012              | SWAN00 Interface Fails to Obtain IP Address After CPE Reboot; Auto-Reconnect Succeeds but IP Address Assignment Fails                                                                         | Mohan Y               | Sivakumar M                | Sev 3    | Resolved | 11/15/2024  | 11/15/2024 05:58 PM | 11/29/2024          | 11/20/2024 05:50 PM | 11/20/2024 | 33118      |                           | Bug        | Fixed - Defects (Generic) | 11/28/2024             | 100         | No     |
| 38040 | Networking-QA         | 1.3.3-build-4 /1.3-03.1012              |  After  Reboot the CPE, Connected Client Hostname and IP Address Missing in Wi-Fi Page                                                                                                        | Saravanakumar E       | Sivakumar M                | Sev 3    | Resolved | 11/15/2024  | 11/15/2024 05:00 PM | 11/22/2024          | 11/21/2024 11:42 AM | 11/21/2024 | 33118      |                           | Bug        | Fixed - Defects (Generic) | 40                     | No          |
| 38039 | Networking-QA         | 1.3.3-build-4 /1.3-03.1012              | In BPIR4 with Asia RF Wi-Fi Chip,5GHz Station Mode Fails to Reconnect Automatically After Hotspot System Reboot                                                                               | Saravanakumar E       | Sivakumar M                | Sev 3    | Resolved | 11/15/2024  | 11/15/2024 04:10 PM | ########            | ########            | ########   | 33118      |                           | Sighting   | Fixed - Defects (Generic) | 100                    | No          |
| 38038 | Networking-QA         | 1.3.3-build-4 /1.3-03.1012              | In BPIR4,Unable to configure the WIFI AP Mode due to Channel Number is  Not Listed                                                                                                            | Saravanakumar E       | Sivakumar M                | Sev 2    | Resolved | 11/14/2024  | 11/14/2024 08:03 PM | 11/20/2024          | 11/18/2024 11:41 AM | 11/18/2024 | 33118      |                           | Bug        | Fixed - Defects (Generic) | 11/20/2024             | 100         | No     |
| 38037 | Networking-QA         | 1.3.3-build-4 /1.3-03.1012              | Unable to Create debug dump From Both secure shell & UI                                                                                                                                       | Saravanakumar E       | DhinaGaran G               | Sev 2    | Resolved | 11/14/2024  | 11/14/2024 06:39 PM | 11/21/2024 08:15 PM | 33118               |            | Bug        |                           |            | 100                       | No                     |
| 38036 | Networking-QA         | 1.3.3-build-4 (1.3.3-RC1) / 1.3-03.1012 | Validation Required to Prevent Duplicate SSID Creation in WiFi Access Point Mode both 2.4GHZ and 5GHZ interface                                                                               | Mohan Y               | Sivakumar M                | Sev 3    | Resolved | 11/14/2024  | 11/14/2024 04:15 PM | 11/28/2024          | 11/20/2024 04:00 PM | 11/20/2024 | 33118      |                           | Bug        | Fixed - Defects (Generic) | 11/20/2024             | 100         | No     |
| 38032 | Networking-QA         | 1.3.3-build-4/ 1.3-01.1012              | After Adding Multiple SSID LAN interface in DNS Page ,unbound service getting failed in AMZ7622                                                                                               | Anitha B              | Sivakumar M                | Sev 1    | Resolved | 11/14/2024  | 11/14/2024 12:23 PM | 11/17/2024          | 11/14/2024 03:54 PM | 11/14/2024 | 33118      |                           | Bug        | Fixed - Defects (Generic) | 11/14/2024             | 100         | No     |
| 38031 | Networking-QA         | 1.3.2-build-21 / 1.3-01.1012            | When disabling the WIFI SSID , Connected Virtaul SSID SET ALIAS got removed in interface page & displayed as WLAN10 ,WLAN11 from LAN10 & LAN11                                                | Anitha B              | Sivakumar M                | Sev 2    | Resolved | 11/13/2024  | 11/13/2024 07:24 PM | 11/14/2024          | 11/14/2024 03:40 PM | 11/14/2024 | 33118      |                           | Bug        | Fixed - Defects (Generic) | 11/15/2024             | 100         | No     |
| 38029 | Networking-QA         | 1.3.2-build-21 / 1.3-01.1012            | While disabling the WLAN interface throws unexpected JSON error                                                                                                                               | Anitha B              | Sivakumar M                | Sev 3    | Resolved | 11/13/2024  | 11/13/2024 07:22 PM | 11/28/2024          | 11/20/2024 05:46 PM | 11/20/2024 | 33118      |                           | Bug        | Fixed - Defects (Generic) | 100                    | No          |
| 38019 | Networking-QA         | 1.3.2-build-21/ 1.3-01.1012             | When adding multiple SSID ,unable to access internet in connected PC after reboot                                                                                                             | Anitha B              | Sivakumar M                | Sev 1    | Resolved | 11/13/2024  | 11/13/2024 07:11 PM | 11/14/2024 01:13 PM | 33118               |            | Bug        | Fixed - Defects (Generic) | 100        | No                        |
| 38018 | Networking-QA         | 1.3.3-build-4 / 1.3-03.1012             | In the BPI-R4, after configuring the virtual SSID, the LANxx name changes to WLANxx after a reboot, resulting in the removal of WLAN interfaces from the interface page                       | Somasundaram R        | Sivakumar M                | Sev 1    | Resolved | 11/13/2024  | 11/13/2024 07:11 PM | 11/21/2024          | 11/14/2024 02:50 PM | 11/14/2024 | 33118      |                           | Bug        | Fixed - Defects (Generic) | 100                    | No          |
| 38017 | Networking-QA         | 1.3.2-build-21 / 1.3-01.1012            | Unable to Create Virtual  SSID in Access Point Mode throws Timeout Exceed  after patch update  in AMZ7622                                                                                     | Anitha B              | Sivakumar M                | Sev 1    | Resolved | 11/13/2024  | 11/13/2024 03:42 PM | 12/13/2024          | 11/14/2024 02:49 PM | 11/14/2024 | 33118      |                           | Bug        | Fixed - Defects (Core)    | 100                    | No          |
| 38011 | Networking-QA         | 1.3.2-build-21 / 1.3-01.1011            | After firmware recovery in HWKX86  from CPE 1.3-01-1011 TO 1010 , some page throws error as cannot open session to kernel                                                                     | Anitha B              | DhinaGaran G               | Sev 1    | Resolved | 11/13/2024  | 11/13/2024 03:24 PM | 11/21/2024 03:55 PM | 33118               |            | Bug        |                           |            | 100                       | No                     |
| 38003 | Networking-QA         | 1.3.2-build-20 / 1.3-01.1011            | The CPE freezes when trying to delete a BOND that was created with 10G and 1G LAN interfaces. To prevent this issue, BOND creation should be restricted for interfaces with mismatched speeds | Somasundaram R        | Sivakumar M                | Sev 2    | Resolved | 11/13/2024  | 11/13/2024 12:22 PM | 11/18/2024 04:15 PM | 33118               |            | Bug        |                           |            | 0                         | No                     |
| 38002 | Networking-QA         | 1.3.2-build-20 / 1.3-01.1011            | Local flow optimiser logs are not being sent to syslog in ELK, causing autoflow control logs and spikes to not appear on the dashboard                                                        | Somasundaram R        | Sharon Enoch               | Sev 2    | Resolved | ########    | ########            |                     |                     | ########   |            | 33118                     |            | Bug                       | Change - Module Update | 0           | No     |


### KNOWN ISSUES

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


### LIMITATIONS


### CPE INSTALLATION

   **https://gitlab.amzetta.com/sdwan/zwan-doc/-/tree/master/CPE_Installation%2FInstallation**

    


