## Flashing zWAN Image on CPE hardware via text console

### Some of x86_64 CPE platforms(e.g CAF-0262) does not comes with VGA/HDMI ports. They have only SERIAL/USB ports.
### To flash zWAN Firmware on such platforms, we need to connect USB-to-Serial cable to take console.

### Follow the below steps to flash firmware via text console mode,

1. Boot the CPE using Live Ubuntu Image thru' text mode
    a. Edit the Try before Install Ubuntu option in GRUB mode: ***console=ttyS0,115200n8 text***
2. Once it is boot into Ubuntu Live image, enter login as ubuntu
3. Copy the latest zWAN FW image file into another USB pendrive and connect it to the CPE
4. Mount the USB pendrive into /media/usb0
    a. ***cd /media/usb0*** and type ls to ensure the FW image file is present
5. Type ***dd if=<FW image file> of=/dev/sda bs=1M status=progress oflag=direct conv=fsync && sync***
6. Shutdown the CPE and remove all the pen drives
7. Boot it thru' Hard drive image
    a. *UEFI Boot mode should be enabled in CPE's BIOS to boot into zWAN Firmware successfully*
8. It will boot into zWAN CPE firmware 
