# Schema

https://gitlab.amzetta.com/sdwan/zwan-cpe/blob/release-0.1.0-diab/common/tegernsee/src/gql/network/modules/route/schema.gql

# GRAPHQL API

## Mutations

### Enable NAT for Interfaces

Specify all the interfaces that need to be enabled or are already enabled in the same command

```
mutation{ enableNATInterfaces(interfaces: [\"ETH01\", \"ETH05\"]){ code, message, success} }
```

## Queries

### List the NAT Status for Interfaces

```
query {
        network {
            getNATInterfaceMap {
                interface
                isNatted
                linkStatus
                description
            }
        }
    }
```

