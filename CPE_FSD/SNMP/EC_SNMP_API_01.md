**Schema**
https://gitlab.amzetta.com/sdwan/zwan-cpe/blob/release-0.1.0-diab/common/tegernsee/src/gql/network/modules/snmp/schema.gql

## GRAPHQL Commands

**Mutations**

*Configure SNMP*

    mutation{
        configureSnmp(
            localIP:[\"192.168.64.1\", \"10.200.3.44\"]
            destinationIP:\"10.200.3.72\"
            communityName:\"demo2\"
            password:\"traxfc123\"){
            code
            success
            message
            }
        }
        
*Edit/Modify SNMP*

    mutation{
        configureSnmp(
            localIP:[\"192.168.64.1\", \"10.200.3.44\"]
            destinationIP:\"10.200.3.72\"
            communityName:\"demo2\"
            password:\"traxfc123\"){
            code
            success
            message
            }
        }
    
*Disable SNMP*

    mutation{
        disableSnmp{
        code
        success
        message
        }
    }
    
*Enable SNMP*

    mutation{
        enableSnmp{
        code
        success
        message
        }
    }
    
*SNMPV3 Configure*

    mutation{
        configureSnmpV3(
            userName:\"demo\"
            protocol:SHA
            password:\"traxfc123\"
            encrption:DES
            encrptionKey:\"password@123\"
            auth:authPriv){
            code
            success
            message
            }
        }
    }
    
*SNMPV3 Delete*

    mutation{
        deleteSnmpV3(
            userName:\"indiadev\"){
            code
            success
            message
            }
    }

**Queries**

*List SNMP*

    query{
        network{
            snmpInfo{
                status
                info{
                    localIP
                    destinationIP
                    communityName
                    }
                }
            }
        }
        
*List SNMPV3*

    query{
        network{ 
            snmpV3{ 
                userName 
                protocol
                encrption 
                auth
            }
        }
    }