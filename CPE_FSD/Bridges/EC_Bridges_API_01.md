# Schema

https://gitlab.amzetta.com/sdwan/zwan-cpe/blob/release-0.1.0-diab/common/tegernsee/src/gql/network/modules/bridge/schema.gql

# GRAPHQL Commands

## Mutations

### Create a Bridge

```
mutation{
  createBridge(
    description : \"br1011\"
    interfaces: [\"ETH02\"]
    stp: true
    forwardDelay: 5
    ageing: 10
  ){
  	code
    success
    message
  }
}
```

### Update a Bridge

mutation{
  updateBridge(
    name: \"BRIDGE01\"
    description : \"br1011\"
    interfaces: [\"ETH02\", \"ETH03\"]
    stp: true
  ){
    code
    success
    message
  }
}

### Delete a Bridge

```
mutation{ deleteBridge( name: "BRIDGE00" ){ code, success, message, name } }
```


## Queries

```
query {
    network {
        bridges {
        name
        description
        stp
        interfaces
        brInterface {
            name
            ipInfo {
                id
                ip {
                    __typename
                    ...on IPv4Info {
                        address
                        netmask
                    }
                }
                dhcp
            }
            vlans {
                vlanInfo {
                    name
                    description
                    tag
                    status
                }
                ipInfo {
                    id
                    ip {
                        __typename
                        ...on IPv4Info {
                            address
                            netmask
                        }
                    }
                    dhcp
                }
            }
            mac
            mtu
            configuredStatus
            linkStatus
            speed
            interfaceType
            description
        }
        forwardDelay
        ageing
        maxAge
        bridgePrio
        helloTime
        }
    }
}
```


