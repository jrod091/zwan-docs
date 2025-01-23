Pre-requisites for Setup:

1.	VMware ESXi 6.7 and above
2.	VMware Vcenter Server 6.7 and above - To manage ESXi server.
3.	Latest zWAN vCPE firmware.
4.	ISP lines and LAN network connect in ESXi server.


Steps for Configuration in ESXi server:

1.	Install VMware ESXi 6.7 and above version in Physical hardware.
2.	Download the CPE vmdk file from below FTP server and copy into the ESXi local datastores OR SAN volumes.
3.	Once copy completed execute the below command to create thin disk so that metadata descriptor file will be create.

vmkfstools –i /vmfs/volumes/datastore1/xxxx.vmdk  /vmfs/volumes/datastore1/xxxxx.vmdk –d thin

4.	In the virtual Switch section in ESXi server enable the below security policy options like.

Promiscuous mode -  Accept  
MAC address changes – Accept  
Forged transmits – Accept  

https://docs.vmware.com/en/VMware-vSphere/7.0/com.vmware.vsphere.networking.doc/GUID-891147DD-3E2E-45A1-9B50-7717C3443DD7.html

5.	Now create a new virtual machine and then choose add existing hard disk and attach the vmdk disk.

CPU: 4 Core and more  
RAM: 4 GB RAM and more  
Network: Add based on LAN and WAN network vswitch  
HDD: existing disk  

6.	Add serial Controller device and choose the option to save the serial.out file in same datastore.
7.	Before click finish button in create virtual machine process, in VM boot option section, choose the boot option as EFI mode instead of BIOS mode.
8.	Now power on the VM, it will boot zWAN firmware.
9.	After Fimrware boot up, Will set the IP for WAN and LAN networks.
10.	Finally, Once conneted WAN IP reaches to Director then we can start the Onboarding process.

