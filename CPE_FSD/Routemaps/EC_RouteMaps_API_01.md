# Schema

https://gitlab.amzetta.com/sdwan/zwan-cpe/blob/release-0.1.0-diab/common/tegernsee/src/gql/network/modules/routemaps/schema.gql

# GRAPHQL API

## Mutations

### Add a Route Map  

```
mutation{ addRouteMapEntry(addRouteMap:{name: \"rm-sharon3\", desc: \"description rm-sharon2\", action: permit, routeOrder: 4, callRouteMap: \"rm-sharon\", exitAction:\"5\",     accessList:\"accesslist1\", prefixList:\"newlist1\", nextHop:{ setNextHop: \"10.0.0.1\"}, bgpCommunity:{ matchType: none, set: [\"65:0\", \"55:0\"], isAdditive: false }, metric:{ match: 20, set: 30 }, weight: 50, localPreference:{ match: 100, set:110 }, origin:{ match: egp, set: igp }, tag:{ match: 600, set: 300 }, sourceProto: none}){ code, message, success } }
```

### Delete a Route Map

```
mutation{ removeRouteMapEntry(removeRouteMap:{seq: 1}){ code, message, success } }
```


## Queries


### List Route Maps
```
query{
  network{
    listRouteMaps{
      seq
      name
      routeOrder
      desc
      action
      callRouteMap
      exitAction
      accessList
      prefixList
      nextHop{
        setNextHop
        matchPeer
        matchNextHopAccess
        matchNextHopPrefix
      }
      nextHopIPv6{
        setPeerAddress
        matchPeer
        matchNextHop
        setPreferGlobal
        setNextHopLocal
        setNextHopGlobal
      }
      metric{
        match
        set
      }
      weight
      localPreference{
        match
        set
      }
      bgpASPaths{
        match
        setType
        set
      }
      bgpCommunity{
        match
        matchType
        isAdditive
        set
      }
      origin{
        match
        set
      }
      sourceProto
      sourceVRF
      tag{
        match
        set
      }
    }
  }
}

```
