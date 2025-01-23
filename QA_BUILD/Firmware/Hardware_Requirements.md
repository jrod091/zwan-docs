### zWAN Hardware Requirements

**This document represents the zWAN Hardware Requirements for Director and EC**

| | | | | |
|-|-|-|-|-|
|**Sl.No**|**Edge Controller Hardware Requirement**|**SOHO/Small Branch**|**SMB/Medium Size Branch**|**DC – Concentrator(each Concentrator supports 256  Branches)**
|1|F/W: CPE 1.2.10xx is QA tested (follow the release notes)F/W: CPE 1.3.000x is in QA)|**EC on ARM H/W:** AMZ z25 (2 core, 1 GB, 4G, 5G, Wifi, 6xGigE) – **NO IPS/IDS, NO DNS Filter**|**EC on X86 h/w:** Kettop Mi10610L8 (i7, 12 cores, 8GB, 4G, Wifi, 8xGigE) – **with IPS/IDS and DNS filter**|**EC on X86 h/w:** Kettop Mi3958 (Atom 16 cores, 8GB, Wifi, 5xGigE, 4x10Gbps) – with IPS/IDS and DNS filter|
| | | **EC on X86 h/w:** Kettop Mi4125L5 (Celeron 4 cores, 4GB, 4G, Wifi, 5xGigE)  - **IPS/IDS or DNS Filter, not both**|**EC on X86 h/w:** Kettop Mi3758RL9 (Atom 8 cores, 8GB, 5G, Wifi, 5xGigE, 4x10Gbps) – **with IPS/IDS and DNS filter**|**vCPE on KVM/HyperV/ESXi:** Each vCPE require (6cores, 4GB, 1xGigE for each WAN/LAN) – without IPS/IDS and DNS filter   KVM deployment - Tested  HyperV/ESXi – not fully verified|
| | | **vEC on Laptop:** Laptop with (4 cores, 4GB RAM, 32GB SSD, Windows 10 or above, 64bit edition, Windows Profession/Enterprise/Education) – **NO IPS/IDS, NO DNS Filter**| | **vCPE on KVM/HyperV/ESXi:** Each vCPE require (8cores, 8GB, 1xGigE for each WAN/LAN) – **with IPS/IDS and DNS filter**|
| | | | | **EC-HA on DC**– Double the above hardware requirement for Active/Passive DC-HA|
| | | | | **EC as Cloud Gateway** – not fully verified|


| | | | | |
|-|-|-|-|-|
|**Sl.No**|**Director Hardware Requirement**|**250 Branches**|**1000 Branches**|**5000 Branches**|
|1|Director TAG  :   1.2.1 is QA tested|**Director on BareMetal:** **Standalone: x86** (16cores,64GB RAM, 1xGigE for each WAN ISP) + **ELK Storage:** 8TB for 6 months data  retention **3 node Cluster:** three times the requirement of Standalone setup|**Director on BareMetal:** **Standalone:** Ubuntu 22.04 (24cores, 128GB, 1xGigE for each WAN ISP) + **ELK Storage:** 32TB for 6 months data retention|**Director on BareMetal:** **Standalone:** Ubuntu 22.04 (32cores, 256GB, 1xGigE for each WAN ISP) + **ELK Storage:** 150TB for 6 months data retention|
|2|Director TAG  :   1.2.2 is QA ready **(ELK Optimization)**|**ELK Storage:** 4TB for 6 months retention| **ELK Storage:** 16TB for 6 months retention | **ELK Storage:** 64TB for 6 months retention|
|3|Director Side BW for **IPFIX and Graphql**|1CPE -> ingress 8MB/hr 1CPE -> 16Kbps 250CPE -> 4Mbps| 1000CPE -> 16Mbps| 5000CPE -> 128Mbps|

















