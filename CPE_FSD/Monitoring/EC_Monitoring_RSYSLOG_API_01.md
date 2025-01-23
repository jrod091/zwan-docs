**Schema**

https://172.16.120.65/sdwan/zwan-cpe/blob/release-0.1.0-diab/common/tegernsee/src/gql/system/modules/logger/schema.gql

** GRAPHQL Commands**

**Mutations**

*Add remote log server*

    mutation {
    addRemoteLogServerInfo (
        remoteLogServer: {remoteServerIP:\"10.11.252.74\",
        protocol:\"TCP\", configuredState:Enabled}
        ) {
        code
        message
        success
            remoteLogServer {
            remoteServerIP
            port
            protocol
            configuredState
            }
        }
    }


*Remove remote log server info*

    mutation{
    removeRemoteLogServerInfo (remoteServerIP:\"10.11.252.74\"){
        code,
        message,
        success
        }
    }

**Query**

    query {
    system {
        remoteLogServer {
            remoteServerIP
            configuredState
            port
            protocol
            }
        }
    }