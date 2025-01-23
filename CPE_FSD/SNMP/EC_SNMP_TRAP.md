# SNMP TRAP
- SNMP (Simple Network Management Protocol) is a widely used protocol for network management. It is used to monitor network devices, such as routers, switches, servers, printers, and more. SNMP traps are unsolicited messages sent by network devices to the SNMP manager indicating that an event has occurred.
### Installed Packages:
```
 $sudo apt-get install -y snmpd snmp
 $sudo apt-get install -y snmp-mibs-downloader
 $sudo apt-get install -y snmptrapd
```
### Mib Browser Installation Steps:

 - Download mibbrowser_linux_x64.zip file from https://www.ireasoning.com/download.shtml
 - Copy downloaded zip file into linux server system
 - Use below commands to extract zip file and run browser code in linux

``` 
 $sudo su
 $unzip mibbrowser_linux_x64.zip
 $cd Downloads/ireasoning/mibbrowser/
 $bash browser.sh
```

## Alert Traps:
 - Link Down Trap: Indicates that a network interface has gone down. display the interface status with hte interface name.
 - Link Up Trap: Indicates that a network interface has come up.  display the interface status with the interface name.
 - Disk usage Trap - Indicates that a disk usage has been reached the critical stage, display the disk usage with the disk name.
 - Memory usage Trap - Indicates that a memory usage has been reached the critical stage.
 - Temperature Trap - Indicates that a sensor has been reached the critical temperature.
 - CPU usage Trap - Indicates that a CPU usage has been reached the critical stage.

### OBJECT Name And Trap Oid,s Of MIB File
| NAME | OID |
| ------ | ------ |
| myCompanyMIB | ``` .1.3.6.1.4.1.54848  ``` |
| interfaceAlertNotifications | ``` .1.3.6.1.4.1.54848.0  ``` |
| systeminfo | ``` .1.3.6.1.4.1.54848.1 ``` |
| info | ``` .1.3.6.1.4.1.54848.1.2 ``` |
| hostname | ``` .1.3.6.1.4.1.54848.1.2.1 ``` |
| ip | ``` .1.3.6.1.4.1.54848.1.2.2 ```|
| hostProductID | ``` .1.3.6.1.4.1.54848.1.2.3 ``` |
| hwType | ``` .1.3.6.1.4.1.54848.1.2.4 ``` |
| dateTime | ``` .1.3.6.1.4.1.54848.1.2.5 ``` |
|interfaceName | ``` .1.3.6.1.4.1.54848.1.2.6 ``` |
|interfaceStatus | ``` .1.3.6.1.4.1.54848.1.2.7 ``` |
|fwVersion| ``` .1.3.6.1.4.1.54848.1.2.8 ``` |
|description| ``` .1.3.6.1.4.1.54848.1.2.9 ``` |
|diskName| ``` .1.3.6.1.4.1.54848.1.2.10 ``` |
|diskUsage| ``` .1.3.6.1.4.1.54848.1.2.11 ``` |
|memoryUsage| ``` .1.3.6.1.4.1.54848.1.2.12 ``` |
|temperature| ``` .1.3.6.1.4.1.54848.1.2.13 ``` |
|cpuUsage| ``` .1.3.6.1.4.1.54848.1.2.14 ``` |

## Documentation structure
# *Trap details*
- Host name: The name of the Hardware device
- Hardware Model - The Hardware Type of the device
- Product ID - The Product ID of the device
- Firmware Version - The Firmware version installed on that device
- Date time - The device date amd time details

# *Trap Information*
- Trap name: The name of the trap 
- Trap Status: The Status of the trap
- OID: Object Identifier for the trap (e.g., .1.3.6.1.4.1.54848.1.2.6).
- Description - The message of the Trap

# *Decoded Trap Message*
- Host Name: bpi-r64
- Hardware Model: aarch64
- Product ID: ZMTKAZA27LQ0JGH-CJCE1QMYD14MIOJ9Q887CR01DJ
- Firmware Version: 1.3-01-0007
- Date Time: Thu Jul 11 06:32:23 AM EDT 2024
- Trap Name: ETH04
- Trap Status: Down
- OID: .1.3.6.1.4.1.54848.1.2.6
- Description : The ETH04 interface has down.

# Trap Handling
### Trap Receiving:
 >  Ensure the SNMP manager is configured to receive traps from the device's IP address.
 >  Verify that the SNMP Version and Receiving Port ID.
 
### Log
  > Record the trap in the event log.
   Include all relevant details such as the timestamp,Trap details, OID, and Alert Type.
 
### Response
> Check the status of the device that sent the trap.
Perform troubleshooting steps based on the trap's information.
Document any actions taken in response to the trap.


### Observation of Trap:
- Go to the MIB browser->Click on Tools-> click trap reciver -> trap reciver window will open 
- Add the trap IP, Select the SNMP version and Port number.
- Click on the trap Receiver. The Receiver tab is displayed in the Browser.
- Once trap generate from agent it will send to server ,trap will come with OID.
