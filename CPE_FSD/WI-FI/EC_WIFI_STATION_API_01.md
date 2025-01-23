**Schema**
https://gitlab.amzetta.com/sdwan/zwan-cpe/blob/1.1_QABUGFIX/common/tegernsee/src/gql/network/modules/wifi/schema.gql

## GRAPHQL Commands

**Mutations**

*Configure Available WIFI Network*

    mutation{
        configureWifiNetwork(
            interface:\"SWAN00\"
            SSID_Name:\"AMZETTAINCF1\"
            password:\"a1rconn3ct\"){ 
            code
            success
            message
            }
        }

*Connect WIFI*

    mutation{
        connectWifiNetwork(
            interface:\"SWAN00\"
            networkID:\"1\" ){
            code
            success
            message
            }
        }

*Disconnect WIFI*

    mutation{
        disconnectWifiNetwork(
            interface:\"SWAN00\"
            networkID:\"1\"){
            code
            success
            message
            }
    }
*Forget/Delete Configured WIFI*

    mutation{
        deleteWifiNetwork(
            interface:\"SWAN00\"
            SSID_Name:\"demo\" ){
            code
            success
            message
            }
    }
**Queries**
*Scan Available WIFI*

    query{
        network{
            wifiNetworks{
                ssid
                signal
                wpaStatus
                networkID
                connectionStatus
            }
        }
    }

  

