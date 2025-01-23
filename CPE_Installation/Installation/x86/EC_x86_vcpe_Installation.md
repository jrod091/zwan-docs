### Flashing Image in x86 vcpe.

### Copy requierd image to vcpe

-   Transfer the necessary image from the specified source path to the designated location on the flash machine.

        **Ex: scp cpe-base-1.2-01.1024-5280.qcow2.xz root@DemoInABoxIP:/var/lib/libvirt/images**

### Shut down the vcpe:

-   Use the command virsh shutdown cpe1/cpe2/cpe3 to shut down the respective vcpe. Replace CPE1/CPE2/CPE3/CPE4 with the specific name of the vcpe you want to shut down.

        **Ex: virsh shutdown CPE1/CPE2/CPE3/CPE4**

### Extract the image:

-   After the shutdown is successful, extract the cpe-base-1.2-01.1024-5280.qcow2.xz file using the command xz -d cpe-base-1.2-01.1024-5280.qcow2.xz.

        **Ex: xz -d cpe-base-1.2-01.1024-5280.qcow2.xz**

### Move the image:

-   Move the extracted image to the respective CPE4.qcow2 location. Use the command mv cpe-base-1.2-01.1024-5280.qcow2 CPE4.qcow2.

        **Ex: mv cpe-base-1.2-01.1024-5280.qcow2 CPE4.qcow2**

### Start the vcpe:

-   Start the vcpe to initiate the firmware boot process. Execute virsh start CPE1/CPE2/CPE3/CPE4 where CPE1/CPE2/CPE3/CPE4 represents the specific vcpe you want to start.

        **Ex: virsh start CPE1/CPE2/CPE3/CPE4**
### Monitor the boot process:

-   Use virsh console to watch the boot process of the vcpe. This command provides access to the console of the vcpe, allowing you to observe the boot messages and status in real-time.

        **Ex: virsh console CPE1/CPE2/CPE3/CPE4**