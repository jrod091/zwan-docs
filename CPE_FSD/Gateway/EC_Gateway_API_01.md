# Schema

https://gitlab.amzetta.com/sdwan/zwan-cpe/blob/release-0.1.0-diab/common/tegernsee/src/gql/network/modules/route/schema.gql

# GRAPHQL  Commands

## Mutations

### Set the default gateway

```
mutation{ setDefaultGateway(viaGateway:\"10.11.0.1\"){ code, success, message } }
```

### Add a static route

```
mutation{ addStaticRoute( routeType: \"Network\", destination: \"10.132.0.0\", netmask: \"255.255.255.0\", gatewayType: GW, viaGateway: \"10.131.0.99\", metric: 1){ code, message, success } }
```

### Delete a Static route

```
mutation{ delStaticRoute(id:"4294901760_2886729728_2147483548"){ code, success, message } }
```

### Enable IP forwarding

```
mutation{enableDisableIPForwarding(enabled:true){code,message,success}}
```

## Queries

### Get Default Gateway

```
query{ 
    network{ 
        getDefaultGateway{
            id
            destination
            netmask
            type
            metric
            gateway
            interface
            flags
            state
            source
        }
    }
}
```

### List routes

```
query {
    network {
        routetable{
            id
            destination
            netmask
            type
            metric
            weight
            gateway
            interface
            flags
            state
            source
        }
    }
}
```