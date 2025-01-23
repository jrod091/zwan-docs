# Schema

https://gitlab.amzetta.com/sdwan/zwan-cpe/blob/release-0.1.0-diab/common/tegernsee/src/gql/network/modules/bgp/schema.gql

# GRAPHQL API

## Mutations

### Enable/Disable BGP 

```
mutation{ enableDisableBGP(enabled: true){ code, message, success}}
```

### Configure ASN and Router ID

```
mutation{ addBGPConfig(addBGP:{localAS: 1, routerID: \"0.0.0.0\", logAdjacency: false, disableDefaultIPv4Unicast: false, keepAliveTimer: 60, holdTimer: 180, updateDelay: 0, peerWait: 0 }) { code, message, success, bgpConfig{ enabled, bgpInst{ localAS,	logAdjacency,	routerID, disableDefaultIPv4Unicast, keepAliveTimer, holdTimer, updateDelay, peerWait	} } } }
```

### Removing a BGP Configuration

```
mutation{ removeBGPConfig(removeBGP:{localAS:64513}){ code, message, success } }
```
### Editing a BGP Configuration

```
mutation { editBGPConfig(editBGP:{localAS: 645136, routerID: \"2.1.2.2\", logAdjacency: true, disableDefaultIPv4Unicast: false, keepAliveTimer: 60, holdTimer: 180, updateDelay: 0, peerWait: 0 }) { code, message, success } }
```

### Configure a BGP Neighbor

```
mutation{ addNeighborConfig( addNeighbor: {localAS:1, nType: peer, addrFamily: IPv4, peerIP:{ipv4:{address:\"193.10.11.2\"}}, remoteAS: \"2\", desc:\"Router 2 of AS2\",keepAliveTimer: 60, holdTimer: 180, connectTimer: 120,passive:false,advertiseInterval:0, advertiseCapability:disabled, disableCapabilityNeg: false, overrideCapabilityNeg: false,
disableConnectedCheck: false, ebgpMultiHop: 1, enforceEBGPMultiHop:false, noPrependEBGP: false,  noPrependIBGP: false,  soloPeer: false, }){code, message, success}}
```

### Delete a BGP Neighbor

```
mutation{ deleteNeighborConfig(deleteNeighbor:{nID:1}){ code, success, message } }
```

### Advertise a Network to a BGP Neighbor

```
mutation{ addAdvertiseNetworkEntry(addAdvertiseNetwork:{localAS:1, ipNetwork: \"195.11.14.0/24\"}){ code, message, success }}
```

### Edit Advanced BGP Config

```
mutation{ editBGPAdvancedRouteConfig( editBGPAdvancedRoute:{ localAS: 20, localPref:100, addrFamily:IPv4, disableFastExtFailover:false, importNetworkCheck:false, routeReflectorOutbound:false, disableClientToClient:false, disableEBGPRouteCheck:false, subgroupPktQueueMax:25, medConf:{ deterministicMED:false, alwaysCompareMED:true, maxMED:false, adminMaxMED:0 } }) { code, message, success }}"
```

### Add Aggregate Address

```
mutation{ addAggregateAddressEntry(addAggregateAddress:{localAS:645136, aggregateAddr: \"10::0/64\", asSet:true, summaryOnly: false}){ code, message, success } }
```

### Delete Aggregate Address

```
mutation{ deleteAggregateAddressEntry(deleteAggregateAddress:{seq:2}){ code, message, success } }
```

### Adding ASPATH List and Entries

```
mutation{ addASPathTable(addASPath:{name: \"hello\", desc: \"hello\"})
mutation{ addASPathEntry(addASPathEntry:{name: \"hello\", action: permit, regex: \"_23456_\"}) {code, message, success}}
mutation{ addASPathEntry(addASPathEntry:{name: \"hello\", action: permit, regex: \"_1310[0-6][0-9]_|_13107[0-1]_\"}) {code, message, success}}
```

### Delete ASPath Entry
```
mutation { deleteASPathEntry(deleteASPathEntry: { name: \"hello\", seq: 1}) { code, success, message } }
```

### Delete ASPath Table
```
mutation { deleteASPathTable(deleteASPath: {name: \"hello\"}) { code, success, message } }```
```

### Adding a Community List

```
mutation { addCommunityList( addCommunityList :{ name: \"TEST\", type: standard, desc: \"Test6\", action: permit, community: [\"internet\" ] } ){ code, success, message } }
mutation { addCommunityList( addCommunityList :{ name: \"TEST7\", type: standard, desc: \"Test7\", action: permit, community: [ \"65432:20\"  "65443:20\" \"internet\" ] } ){ code, success, message } }
```

### Deleting a Community List

```
mutation { deleteCommunityList( deleteCommunityList :{ name: \"TEST\", seq: 60} ){ code, success, message } }
```

## Queries


### BGP Configuration
```
query { network { getBGPConfig { enabled, bgpInst { routerID, localAS, logAdjacency, disableDefaultIPv4Unicast, keepAliveTimer, holdTimer, updateDelay, peerWait, reDistribute { enabled, addrFamily, type, metric, routeMap } } } } }
```

### Query BGP Config File
```
query { network { getBGPConfigFile { type, fullText } } }
```

### Advanced BGP Routing Configuration
```
query { network { getBGPAdvancedRouteConfig(localAS: 65435) {
                localAS
                addrFamily
                localPref
                routemapDelay
                damp {
                    penaltyHalflife
                    whentoReuse
                    startSupressRoute
                    maxSupressTime
                }
                disableFastExtFailover
                importNetworkCheck
                routeReflectorClusterID {
                    __typename
                    ... on BGPClusterID {
                        id
                    }
                    ... on BGPClusterIP {
                        address
                    }
                }
                routeReflectorOutbound
                disableClientToClient
                medConf {
                    deterministicMED
                    alwaysCompareMED
                    maxMED
                    adminMaxMED
                    maxMEDStartupTime
                    maxMEDValue
                }
                confederationAS
                confederationPeers
                adminDistance {
                    distance
                    ipsourcePrefix
                    accessList
                }
                bgpDistance {
                    externalRoutesDistance
                    internalRoutesDistance
                    localRoutesDistance
                }
                bestPath {
                    aspathConfed
                    aspathIgnore
                    multipathRelax
                    generateAS
                    compareRouterID
                    compareMEDConfed
                    missingMEDWorst
                }
                disableEBGPRouteCheck
                subgroupPktQueueMax
            }
        }
    }
```

### Advertise Network Entries

``` 
query{ network{ listAdvertiseNetworkEntries(localAS:645136){ ipNetwork, routeMap, addrFamily, seq } } }
```

### List BGP Neighbors

```
query {
        network {
            listBGPNeighbors {
                nID
                localAS
                nType
                shutdown
                version
                addrFamily
                peerIP {
                    __typename
                    ... on IPv4Info {
                        IPv4Address: address
                        netmask
                    }
                    ... on IPv6Info {
                        IPv6Address: address
                        prefixLength
                    }
                }
                peerGroup
                remoteAS
                desc
                authKey
                updateSource
                keepAliveTimer
                holdTimer
                connectTimer
                passive
                advertiseInterval
                advertiseCapability
                disableCapabilityNeg
                overrideCapabilityNeg
                ttlSecurityHops
                disableConnectedCheck
                ebgpMultiHop
                enforceEBGPMultiHop
                alternateAS
                noPrependEBGP
                noPrependIBGP
                soloPeer
                peerAddrFamily {
                    isDefaultOriginate
                    defaultOriginate
                    nextHopSelf
                    sendCommunity
                    softReconfig
                    distributeListIn
                    distributeListOut
                    prefixListIn
                    prefixListOut
                    asPathListIn
                    asPathListOut
                    routeMapIn
                    routeMapOut
                    unSuppressRouteMap
                    weight
                    advertiseAllPaths
                    advertiseBestPathsperAS
                    allowASInbound
                    asOverride
                    attrUnchanged
                    asPathAttrUnchanged
                    medAttrUnchanged
                    nextHopAttrUnchanged
                    orfPrefixList
                    maxPrefix
                    threshold
                    warningOnly
                    restartInterval
                    removePrivateAS
                    removePrivateASAll
                    replacePrivateASLocal
                    routeReflectorClient
                    routeServerClient
                }
            }
        }
    }
```

### Aggregate Address

```
query{ network{ listAggregrateAddresses(localAS:645136){ addrFamily,aggregateAddr, seq, asSet, summaryOnly, routeMap } } }
```

### ASPath List and Entries

```
query{ network{ listASPathLists{ name, desc } } }
query{ network{ listASPathEntries(name:\"hello\"){ seq, action, regex } } }
```

### Community lists

```
query{ network { getCommunityLists { wellKnownCommunities, localCreatedCommunities { name, desc, type, action, community, seq } } } } 
```


