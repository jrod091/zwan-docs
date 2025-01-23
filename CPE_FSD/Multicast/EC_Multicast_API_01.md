# Schema

https://gitlab.amzetta.com/sdwan/zwan-cpe/blob/release-0.1.0-diab/common/tegernsee/src/gql/network/modules/pim/schema.gql

# GRAPHQL API

## Mutations

### Enabling and Disabling the PIMD daemon

```
mutation{ enableDisablePIM(enabled: true){ code, message, success } }
mutation{ enableDisablePIM(enabled: false){ code, message, success } }
```

### Add PIM Config

```
mutation{ addPIMConfig(addPIM:{sptPrefixList:\"newlist2\", ssmPrefixList:\"newlist3\", ecmp: true, ecmpRebalance : false, sptEnabled: false,joinPruneInterval: 60, keepAliveTimer:210, packets: 3, registerSuppressTime:60, mcastRPFLookupMode:mrib_then_urib}){ code, message, success } }
```

### Add PIM Interface 

```
mutation{ addPIMInterfaceConfig(addPIMInterface:{interfaceName:\"ETH04\", bfd:false, bsm: true, bsmUnicast: true, drPriority:1, holdInterval:105, helloInterval: 30}){ code, message, success } }
```
### Edit PIM Interface

```
mutation{ editPIMInterfaceConfig(editPIMInterface:{interfaceName:\"ETH04\", bfd:false, bsm: true, bsmUnicast: true, drPriority:2, holdInterval:105, helloInterval: 30}){ code, message, success } }
```

### Delete PIM Interface

```
mutation{ removePIMInterfaceConfig(removePIMInterface:{interfaceName:\"ETH04\"}){ code, message, success } }
```

### Add IGMP interface

```
mutation{ addIGMPInterfaceConfig( addIGMPInterface: { interfaceName: \"ETH04\",version:3, queryInterval:125, queryMaxResponseTime:100, lastMemberQueryCount: 2, lastMemberQueryInterval:10}){ code, message, success } }
```

### Edit IGMP interface

```
mutation{ editIGMPInterfaceConfig( editIGMPInterface: { interfaceName: "ETH04",version:3, queryInterval:126, queryMaxResponseTime:101, lastMemberQueryCount: 3, lastMemberQueryInterval:100}){ code,    message, success } }
```


### Delete IGMP Interface

```
mutation{ removeIGMPInterfaceConfig(removeIGMPInterface:{interfaceName:\"ETH04\"}){ code, message, success }}
```

## Queries

### List the PIM Configuration

query{
  network{
    getPIMConfig{
      enabled
      pimInst{
        vrfName
        rp{
          ip
          groupRange
          rpPrefixList
        }
        ecmp
        ecmpRebalance
        registerSuppressTime
        packets
        joinPruneInterval
        mcastRPFLookupMode
        keepAliveTimer
        ssmPrefixList
        sptPrefixList
        sptEnabled
        sendV6Secondary
        pimInterfaces{
          interfaceName
          vrfName
          bfd
          bsm
          bsmUnicast
          helloInterval
          holdInterval
          mcastBOILPrefixList
          drPriority
        }
        igmpInterfaces{
          interfaceName
          vrfName
          queryInterval
          queryMaxResponseTime
          lastMemberQueryCount
          lastMemberQueryInterval
          version
        }
      }
    }
  }
}
