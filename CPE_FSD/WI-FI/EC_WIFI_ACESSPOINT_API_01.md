**Schema**

https://gitlab.amzetta.com/sdwan/zwan-cpe/blob/1.1_QABUGFIX/common/tegernsee/src/gql/network/modules/wifi/schema.gql

## GRAPHQL Commands

**Mutations**

*Configure Wifi Access Point*

    mutation{   
        configureWifi(  interface:\"WLAN00\"
                        SSID_Name:\"wifibpi\"
                        SSID_Broadcast:1 
                        driver:\"802.11n\" 
                        mode:\"a\"
                        c_code:\"IN\"   
                        channel:\"4\"
                        wpa:2
                        security:\"CCMP\"
                        password:\"traxfc123\"){
                        code
                        success
                        message
        }
    }

*Edit Wifi Access Point*

    mutation{   
        configureWifi(  interface:\"WLAN00\"
                        SSID_Name:\"wifibpi\"
                        SSID_Broadcast:1 
                        driver:\"802.11n\" 
                        mode:\"a\"
                        c_code:\"IN\"   
                        channel:\"4\"
                        wpa:2
                        security:\"CCMP\"
                        password:\"traxfc123\"){
                        code
                        success
                        message
        }
    }

*Enable Wifi Acess Point*

    mutation{
        enableWifi( interface:\"WLAN00\"){
                    code
                    success
                    message
        }
    }

*Disable Wifi Acess Point*

    mutation{
        disableWifi( interface:\"WLAN00\"){
                     code
                     success
                     message
        }
    }
    
*Configure Multiple SSID*

    mutation{   
        configureVirtualWifiNetwork( parent_interface:\"LAN05\"
                                     interface:\"\"
                                     SSID_Name:\"bpir64_2.4GHzvr3\"
                                     SSID_Broadcast:0 
                                     wpa:2
                                     security:\"AUTO\"
                                     password:\"password\"){
                                     code
                                     success
                                     message
        }
    }
    
*Edit Multiple SSID interface*

    mutation{   
        configureVirtualWifiNetwork( parent interface: \"LAN05\"
                                     interface: \"LAN10\"
                                     SSID_Name: \"bpir64_2.4GHzvr3"\
                                     SSID_Broadcast: 0
                                     wpa: 2
                                     security": \"AUTO\"
                                     password: \"password"\
                                     code
                                     success
                                     message
        }
    }
 
*Enable Multiple SSID interface*

    mutation{
        enableWifi( interface:\"LAN10\"){
                    code
                    success
                    message
        }
    }

*Disable Multiple SSID interface*

    mutation{
        disableWifi( interface:\"LAN10\"){
                     code
                     success
                     message
        }
    }

*Delete Multiple SSID interface*

    mutation{   
        deleteVirtualWifiNetwork( interface: \"LAN10\"
                                  code
                                  success
                                  message
        }
    }
 
**Queries**

*List Acess Point & Multiple SSID Configured Info *

    query{
        network{
            wifiAp{
                    interface
                    Allowed_VSSID
                    SSID_Name
                    SSID_Broadcast
                    c_code
                    channel
                    phyDevice
                    mode
                    wpa
                    security
                    frequencyBand
                    status
                    channelList
                    virtual_ssids {
                        bss
                        SSID_Name
                        SSID_Broadcast
                        wpa
                        security
                        status
                }
            }
        }
    }
    
*List Acess Point Connected Client Info*

    query{
        network{
            wifiClients{
                        ip
                        host
                        rx
                        tx
                        cnTime
                        mac 
            } 
        }
    }