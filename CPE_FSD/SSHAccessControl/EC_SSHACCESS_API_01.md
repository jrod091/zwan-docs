**Schema**

https://172.16.120.65/sdwan/zwan-cpe/blob/release-0.1.0-diab/common/tegernsee/src/gql/system/modules/ssh/schema.gql

**GRAPHQL API**

**Mutations**

*Enable/Disable SSH ACL*

    mutation{
        saveSshAcl(
            configuredStatus: true
        
        ){
            code
            message
            success
            acls{
            ips
            subnets
            ifaces
            configuredStatus
            }
        }
    }

*Add SSH ACL*

        mutation{
        saveSshAcl(
            ips: [\"22.22.22.2\"],
            subnets: [\"10.11.0.0/16\",\"172.16.0.0/255.255.0.0\"],
                ifaces: [\"ETH06 vlan 12\", \"ETH04\"]
            configuredStatus: true
            
        ){
            code
            message
            success
            acls{
            ips
            subnets
            ifaces
            configuredStatus
            }
        }
        }

**Queries**

*List availbale interface for which ACL can be configured*

    query  {
        system {
            ifaces 
        }
    }

*List all configured SSH ACLS*

    query{
        system{
            sshacls{
            ips
            ifaces
            subnets
            configuredStatus
            }
        }
    }

