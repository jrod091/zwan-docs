# Schema

https://gitlab.amzetta.com/sdwan/edge-controller-provisioner/blob/development/service/src/gql/amz/modules/edge-controllers/schema.gql


# GraphQL API

## Mutations

### Onboard an edge controller at MSP
```
mutation {onboardProductByID (productID:\"PRODUCT_ID_001\", description:\"Branch 1\", tunnel_ip:\"10.131.0.0.101\", tunnel_port:1194) {code,success,message}}
```

## Queries

### List all edge controller that added to MSP Server

```
query { network { productID } }
```

### Retrive onboard status of an Edge Controller.

```
query {network { mgmtTunnelInfo (productKey: \"PRODUCT_ID_001\" ) {productID, description, onBoard, cn, hostCrt, hostKey, caCrt, tunnelIP, tunnelPort, mgmtClientIP, mgmtServerIP, mgmtNetMask,mgmtSshKey } } }
```

