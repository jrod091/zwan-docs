**Schema**

https://172.16.120.65/sdwan/zwan-cpe/blob/release-0.1.0-diab/common/tegernsee/src/gql/network/modules/ipfix/schema.gql

**GRAPHQL API**

*Enable/Disable IPFIX config*

    mutation{
    enableDisableIpfix(configuredState:Enabled,serviceName:twamp){
        code,
        message,
        success,
        ipfixInfo {
        collectorIP
        configuredState
        }
        
    }
    }


*Modify ipfix config*

    mutation{
        editIPFixCpe(ipFixCpe:{configuredState:Enabled 
                                collectorIP:\"10.11.50.162\"
                                udpPort:4739,
                                tcpPort:4739}) {
            code,
            message,
            success,
            ipFixCpe {
            configuredState
            collectorIP
            tcpPort
            udpPort
            }
        }
        } 

*Remove IPFIX collector*

    mutation {
        removeIPFixCpe(ipFixCpe:{collectorIP:\"10.11.234.12\") { code,
        message,
        success}
    }

**Query**

*List ipfix collector information*

    query{
        network{
            ipFixCpe {
            collectorIP,
            tcpPort,
            udpPort
            }
        }
    }


*List ipfix services information*

    query {
    network {
        listIPFixService {
            collectorIP
            configuredState }
        }
    }