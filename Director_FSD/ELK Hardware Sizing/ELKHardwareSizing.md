# Hardware Configuration-ELK

**Overview**

This document refers the server and VM configuration for ELK for 30 Days data with 100 BPI's /vCPE's.

**Server Configuration for Standalone Director**

| **Server Configuration for Standalone Server** |  |
| ------ | ------ |
| Server Model | HPE   ProLiant DL380 Gen10 |
| Storage | 3 TB   RAID5 SSD | 
| Thread(s)   per core: | 2
| Core(s)   per socket: | 16
| Socket(s): | 2
| CPU(s): | 64
| Processor | Intel(R) Xeon(R) Gold 6226R CPU @ 2.90GHz
| RAM | 256 GB DDR4


**ELK VM configuration**


To change the ELK VM Configuration to 48GB RAM /32 vCPU by following the below steps

1. Power off the elk vm by using the command virsh shutdown elk1
2. In the host machine give the command virsh edit elk1
3. Select the editor
4. Change the memory --> <memory unit='KiB'>33554432</memory>
5. Change the vCPU --> <vcpu placement='static'>8</vcpu>
6. Power on the VM by using the command virsh start elk1

To change the docker VM memory 32GB RAM under res/docker-compose.yaml file by following the below steps

1. login to host machine, go to elk foler  ex: cd /home/user/elk1 
2. vagrant ssh
3. sudo bash
4. vi /home/vagrant/zwan/elk/opendistro/res/docker-compose.yaml.template.
5. for odfe-node increase the ram from 8 to 32 for the environment variable called xms and xmg.
6. run the remove.sh script under the path /home/vagrant/zwan/elk/opendistro.
7. run the setup.sh script in same path to make it effect.

**Approximate ELK VM Configuration for 30 /60 Days with 100 BPI / 100 vCPEs**

| **ELK VM Configuration** |  |
| ------ | ------ |
| No of Days Data | RAM | CPU | Storage |
| 30 Days | 48GB | 32vCPU | 500GB | 
| 60 Days | 96GB | 64vCPU | 1TB | 		


**Extrapolated the ELK Storage requirement from the data with around 20 CPEs.**

| No of CPE's | 1 | 100 | 500 | 1000 | 3000 | 5000 |
| ------ | ------ | ------ | ------ | ------ | ------ | ------ |
| **Duration** | **Storage Size** | | | |
| 1 Hr | 10.10 MB | 1010.00 MB  | 4.93 GB | 9.86 GB | 29.59 GB | 49.32 GB |
| 1 Day | 242.40 MB | 23.67 GB  | 118.36 GB | 236.72 GB | 710.16 GB | 1183.59 GB |
| 1 Month | 7.10 GB | 710.16 GB | 3.47 TB | 6.94 TB | 20.81 TB | 34.68 TB |
| 3 Months | 21.30 GB | 2.08 TB | 10.40 TB | 20.81 TB | 62.42 TB | 104.03 TB |
| 6 Months | 42.61 GB | 4.16 TB | 20.81 TB | 41.61 TB | 124.83 TB | 208.05 TB |


**Test Results for systrome tag version 0.1.8-r17**

**ELK validation for 30 Days data with 100 BPI's in Standalone Setup**

| **Test Results** |  | | | | |
| ------ | ------ | ------ | ------ | ------ | ------ |
| No of Days Data | 32GB RAM / 32 vCPU | 32GB RAM and 16vCPUs | 20GB RAM / 32 vCPU | 20GB RAM / 16 vCPU | 20GB RAM / 8 vCPU |
| 7 Days | 15 Seconds | 2 Minutes 10 Seconds | 1 Minutes 28 seconds | 1 Minutes 53 seconds | 8 Minutes 45 seconds |
| 15 Days | 2 Minutes 03 seconds | 3 Minutes 16 Seconds | 2 Minutes 50 seconds | 3 Minutes 18 seconds | 14 Minutes 49 seconds |
| 20 Days | 30 seconds | 4 Minutes 25 Seconds | 4 Minutes 08 seconds | 4 Minutes 51 seconds | 10 Minutes 29 seconds |
| 25 Days | 30 seconds | 5 Minutes 10 Seconds | 4 Minutes 59 seconds | 6 Minutes 10 seconds | 11 Minutes 51 seconds |
| 30 Days | 33 seconds | 6 Minutes 0 Seconds | 5 Minutes 20 seconds | 13 Minutes 14 seconds | 28 Minutes 48 seconds |