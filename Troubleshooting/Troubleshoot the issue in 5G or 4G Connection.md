LTE interface not getting IP:
    
   1. Please make sure, you recieved any PRIVATEAPN from the service provider.
     If so please use the "Add PrivateAPN" option of respective LTE interface in the Edge controller UI Interfaces page.
      
   2. Disable and Enable the respective LTE interface in the Edge controller UI Interfaces page.

   3. Make sure all Antennas are connected and are intact, if needed reconnect the Antennas.
    
------------------------------------------------------------------------------------------------------
LTE interface / Modem not listed:
   - Reboot the Edge controller.

------------------------------------------------------------------------------------------------------
  
T-Mobile SIM : 192.0.0.2 IP issue:
    
        Please execute the following AT commands and reboot the Edge controller once.
        If the respevtive LTE interface is not getting IPv4 IP ( not 192.0.0.2 ), 
        repeat the steps and reboot the unit.
        
        Note:   Same steps for 4G or 5G. 
                Find the resepective serial device using the mmcli output to send the AT commands to the Modem.
        
        bash-5.1# mmcli -L
        /org/freedesktop/ModemManager1/Modem/1 [QUALCOMM INCORPORATED] QUECTEL Mobile Broadband Module
        /org/freedesktop/ModemManager1/Modem/0 [QUALCOMM INCORPORATED] QUECTEL Mobile Broadband Module
        /org/freedesktop/ModemManager1/Modem/2 [Quectel] RM530N-GL
        
        bash-5.1# mmcli -m 2
          ----------------------------------
          General  |                   path: /org/freedesktop/ModemManager1/Modem/2
                   |              device id: e38c985906075c1108a58bb871d2b7c08bd5e205
          ----------------------------------
          Hardware |           manufacturer: Quectel
                   |                  model: RM530N-GL
                   |      firmware revision: RM530NGLAAR01A02M4G
                   |         carrier config: default
                   |           h/w revision: 20000
                   |              supported: gsm-umts, lte, 5gnr
                   |                current: gsm-umts, lte, 5gnr
                   |           equipment id: 867978050003473
          ----------------------------------
          System   |                 device: /sys/devices/platform/1a0c0000.usb/usb4/4-1
                   |                drivers: option, qmi_wwan
                   |                 plugin: quectel
                   |           primary port: cdc-wdm1
                   |                  ports: cdc-wdm1 (qmi), ttyUSB6 (at), ttyUSB7 (at), wwan1 (net)
        

Either Minicom or Socat can be used to execute the AT commands. If you see morethan 1 ttyUSB? (at) listed in the mmcli output, start from last one as shown below.

    Using minicom :
    ***************

        minicom -D /dev/ttyUSB7
        
        AT+CFUN=0
        AT+QMBNCFG="AutoSel",0
        AT+QMBNCFG="Deactivate"
        AT+QMBNCFG="select","ROW_Generic_3GPP_PTCRB_GCF"
        AT+CFUN=1,1
        AT+QCFG="CLAT",1,1,"",0,"",0,0,0,0,0,0
        AT$QCPRFMOD=PID:1,OVRRIDEHOPDP:"IPV6"
        AT+CFUN=1,1
        AT$QCPRFMOD=PID:1,OVRRIDEHOPDP:""
        AT+QCFG="CLAT",0
        AT+QNWPREFCFG="mode_pref", AUTO

        #To exit from minicom
        Ctrl+A  Z

        # Reboot the BPI 

        After AT+CFUN=1,1  , Modem will reset. So 1-2 minutes the minicom session will not work. 
        Once Modem resets, again it will reconnect. 
        After that you can execute commands that are after AT+CFUN=1,1.
        Once all commands are executed, come out of Minicom and Reboot the BPI.

        with the above steps, not getting IPV4 IP, then do the following.
         
            AT+QNWPREFCFG="nr5g_disable_mode",1

   Using socat :
   *************
    
        echo AT+CFUN=0 | sudo socat - /dev/ttyUSB7,crnl
        echo AT+QMBNCFG=\"AutoSel\",0 | sudo socat - /dev/ttyUSB7,crnl
        echo AT+QMBNCFG=\"Deactivate\" | sudo socat - /dev/ttyUSB7,crnl
        echo AT+QMBNCFG=\"Select\",\"ROW_Generic_3GPP_PTCRB_GCF\" | sudo socat - /dev/ttyUSB7,crnl
        echo AT+CFUN=1,1 | sudo socat - /dev/ttyUSB7,crnl
        sleep 120
        echo AT+QCFG=\"CLAT\",1,1,\"\",0,\"\",0,0,0,0,0,0 | sudo socat - /dev/ttyUSB7,crnl
        echo AT$QCPRFMOD=PID:1,OVRRIDEHOPDP:\"IPV6\" | sudo socat - /dev/ttyUSB7,crnl
        echo AT+CFUN=1,1 | sudo socat - /dev/ttyUSB7,crnl
        sleep 120
        echo AT$QCPRFMOD=PID:1,OVRRIDEHOPDP:\"\" | sudo socat - /dev/ttyUSB7,crnl
        echo AT+QCFG=\"CLAT\",0 | sudo socat - /dev/ttyUSB7,crnl
        echo AT+QNWPREFCFG=\"mode_pref\", AUTO | sudo socat - /dev/ttyUSB7,crnl

        # Reboot the BPI 

        After AT+CFUN=1,1  , Modem will reset. So 1-2 minutes, so wait for 2 minutes.
        Then you can execute commands that are after AT+CFUN=1,1.
        Once all commands are executed, Reboot the BPI.

        with the above steps, not getting IPV4 IP, then do the following.
        
            echo AT+QNWPREFCFG=\"nr5g_disable_mode\",1 | sudo socat - /dev/ttyUSB7,crnl

------------------------------------------------------------------------------------------------------
Modem mode setting: LTE Mode:

      echo AT+QNWPREFCFG=\"mode_pref\",LTE  | sudo socat - /dev/ttyUSB7,crnl
      
      Once the mode is changed, please Disable and Enable the LTE interface from Edge controller UI interfaces page.
      Or reboot the unit once.

------------------------------------------------------------------------------------------------------
Power Cycle the LTE Modem(s):

   1. 5G
      power OFF:
         echo 0 > /sys/class/gpio/power-5g/value

      power ON:
         echo 1 > /sys/class/gpio/power-5g/value

   2. 4G LTE1

      power OFF:
         echo 0 > /sys/class/gpio/power-lte1/value

      power ON:
         echo 1 > /sys/class/gpio/power-lte1/value

   3. 4G LTE2

      power OFF:
         echo 0 > /sys/class/gpio/power-lte2/value

      power ON:
         echo 1 > /sys/class/gpio/power-lte2/value

      Once power cycle commands executed, wait for 1-2 mins.
      
      Check "lsusb" command output for Modem reloaded.
      lsusb
         Bus 002 Device 001: ID 1d6b:0003 Linux Foundation 3.0 root hub
         Bus 001 Device 002: ID 2c7c:0125 Quectel Wireless Solutions Co., Ltd. EC25 LTE modem
         Bus 001 Device 003: ID 2c7c:0125 Quectel Wireless Solutions Co., Ltd. EC25 LTE modem
         Bus 001 Device 001: ID 1d6b:0002 Linux Foundation 2.0 root hub
         Bus 004 Device 002: ID 2c7c:0800 Quectel Wireless Solutions Co., Ltd. RM502Q-AE
         Bus 004 Device 001: ID 1d6b:0003 Linux Foundation 3.0 root hub
         Bus 003 Device 001: ID 1d6b:0002 Linux Foundation 2.0 root hub

      Check "mmcli -L" command output for Modem reloaded in ModemManager.
      
      mmcli -L
         /org/freedesktop/ModemManager1/Modem/1 [QUALCOMM INCORPORATED] QUECTEL Mobile Broadband Module
         /org/freedesktop/ModemManager1/Modem/0 [QUALCOMM INCORPORATED] QUECTEL Mobile Broadband Module
         /org/freedesktop/ModemManager1/Modem/2 [Quectel] RM502Q-AE

      If the Modem is not listed in "mmcli -L" output, restart the ModemManager service, 
      and check the "mmcli -L" output again.

         service ModemManager restart

      If that also didn't help, reboot the Edge Controller once.

------------------------------------------------------------------------------------------------------

AT commands Manuals:

   1. For Quectel 5G Modem(s): Please refer the following manual.
      https://www.quectel.com/download/quectel_rg50xqrm5xxq_series_at_commands_manual_v1-1-2/

   2. For Quectel 4G/LTE Modem(s): Please refer the following manual.
      https://forums.quectel.com/uploads/short-url/A4rEKqqtf17nlInpzz8jIhF06GN.pdf









            
    
