# Schema

https://172.16.120.65/sdwan/zwan-cpe/blob/release-0.1.0-diab/common/tegernsee/src/gql/network/modules/interface/schema.gql

# CURL Commands

## Mutations

*Create VLAN*

    mutation {
        {  
            createVLAN(name:\"ETH04\" , description: \"testing\", tag: 11)
            {  code,
               success,
               message
            } }
    }

*Delete VLAN*

    mutation {
        {  
            deleteVLAN(name:\"ETH04\",tag: 11)
            {  code,
               success,
               message
            } }
    }

*Edit VLAN*

    mutation {
        {  
            editVLAN(name:\"ETH04\" , description: \"testing\", tag: 11)
            {  code,
               success,
               message
            } }
    }


*Add Static IP for a VLAN *

    mutation{
    addIP(
        name: \"ETH04\"
        tag:11
        ip: { 
        ipv4: {
        address:\"72.56.55.3\"
            netmask:\"255.255.0.0\"
            }
        }
        interfaceType:VLAN
    ){
    code
    message
    success
        interface {
            vlans{
                vlanInfo{
                name
                tag
                description
                }
                ipInfo{
                ip{
                    __typename
                    ... on IPv4Info{
                    address
                    netmask
                    }
                }
                id
                }
            }
            ipInfo{
                ip{
                __typename 
                ... on IPv4Info {
                        address
                            netmask
                    } 
                }
                dhcp
                id
            }
            name
            mac
            speed
            configuredStatus
            linkStatus
            }
        }
    }

*Modify Static IP for a VLAN *

    mutation{
        modifyIP(
            name: "ETH04"
            tag:11
            interfaceType:VLAN
            ip: { 
            ipv4: {
            address:\"72.56.55.8\"
                netmask:\"255.255.0.0\"
                }
            }
            id: "00"
        ){
        code
        message
        success
            interface {
            vlans{
                vlanInfo{
                name
                tag
                description
                }
                ipInfo{
                ip{
                    __typename
                    ... on IPv4Info{
                    address
                    netmask
                    }
                }
                id
                }
            }
            ipInfo{
                ip{
                __typename 
                ... on IPv4Info {
                        address
                            netmask
                    } 
                }
                dhcp
                id
            }
            name
            mac
            speed
            configuredStatus
            linkStatus
            }
        }
    }

*Remove static IP of a VLAN, Each IP willhave a unique ID*

    mutation{
        removeIP(
            name: \"ETH04\"
            id: \"00\",
            tag:11,
            interfaceType:VLAN )
            {
                code
                success
                message
            }
    }


## Queries

VLAN info will be listed in the interface object query. The required VLAN object fields needs to be expanded based on need.
