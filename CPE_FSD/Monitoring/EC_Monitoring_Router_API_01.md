# Schema

https://gitlab.amzetta.com/sdwan/zwan-cpe/blob/release-0.1.0-diab/common/tegernsee/src/gql/network/modules/bgp/schema.gql
https://gitlab.amzetta.com/sdwan/zwan-cpe/blob/release-0.1.0-diab/common/tegernsee/src/gql/network/modules/ospf/schema.gql
https://gitlab.amzetta.com/sdwan/zwan-cpe/blob/release-0.1.0-diab/common/tegernsee/src/gql/network/modules/pim/schema.gql


# GRAPHQL Commands

## Mutations

### Execute a command to retreive information on a routing protocol

```
mutation{ executePIMShowCmds(cmdID:1){ code, message, success, output{ cmdConstant{ cmd, cmdID, cmdDesc } showCmdOutput } } }
```