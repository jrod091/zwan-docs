# Schema

https://gitlab.amzetta.com/sdwan/zwan-cpe/blob/release-0.1.0-diab/common/tegernsee/src/gql/network/modules/ospf/schema.gql


# GRAPHQL API

## Mutations

### Enable/Disable OSPF 

```
mutation{ enableDisableOSPF(enabled: true){ code, message, success}}
```

### Adding an OSPF Configuration

```
mutation{
  addOSPFConfig(
    addOSPF:{
      instanceID: 0
      vrfName:"amzDefault"
      routerID:"1.1.1.1"
      logAdjacency:disabled
      spfDelay:10
      spfHoldtime: 20
      spfMaxHoldTime: 100
      rfc1583:false
      opaqueLSA:false
      maxMetric:false
      abrType:cisco
      defInfo:{
      	reDistributeDefault:false
        alwaysRedistribute:false
      }
    }
  )
	{
    code
    success
    message
  }
}
```

### Add an OSPF Area Configurtion

```
mutation {
  addOSPFAreaConfig(
    addOSPFArea:{
      areaInfo:{uid:{id:0}}
      type:default
      authType:none
      shortCut:default
			defaultCost:2
    }
  ){
    code
    success
    message
  }
}
```

### Add an OSPF Area Range Configuration

```
mutation {
  addOSPFAreaRangeConfig(
    addOSPFAreaRange:{
      areaInfo:{uid:{id:1}}
      rangePrefix:"32.0.0.0/8"
      notAdvertise:false
      cost:11
      substitutePrefix: "32.1.1.5/8"
    }
  ){
    code
    success
    message
  }
}
```

### Add an OSPF Interface Configuration

```
mutation{
 addOSPFInterfaceConfig(
   addOSPFInterface:{
     instanceID: 0
     vrfName: "amzDefault"
     interfaceName:"ETH03"
    authType: simple
     passiveInterface:false
     areaInfo:{uid:{id:0}}
     networkType:non_broadcast
    params:{
      helloInterval:10
      deadInterval:120
      retransmitInterval:20
      transmitDelay:10
      helloMultiplier: 2
      mtuIgnore: true
      linkCost: 2
      drPriority: 2
    }
  }
  )
	{
    code
    success
    message
  }
}
```

### Add an OSPF Redistribution Configuration

```
mutation{
  setOSPFReDistributeConfig(
    setOSPFReDistribute:{
      instanceID:0
      vrfName:"amzDefault"
      type:connected 
      enabled:true
    })
	{
    code
    success
    message
  }
}
```

### Editing aa OSPF Configuration

```
mutation{
 editOSPFConfig(
	editOSPF:{
      routerID:"1.1.1.1"
      logAdjacency:disabled
      spfDelay:10
      spfHoldtime: 200
      spfMaxHoldTime: 1000
      rfc1583:true
      opaqueLSA:false
      maxMetric:false
      abrType:cisco
      defInfo:{
      	reDistributeDefault:true
        alwaysRedistribute:false
      }
    }
  )
	{
    code
    success
    message
  }
}
```

### Edit an OSPF Interface Configuration

```
mutation{
 editOSPFInterfaceConfig(
   editOSPFInterface:{
     instanceID: 0
     vrfName: "amzDefault"
     interfaceName:"ETH03"
    	authType: none
     passiveInterface:false
     areaInfo:{uid:{id:0}}
     networkType:non_broadcast
    params:{
      helloInterval:10
      deadInterval:120
      retransmitInterval:20
      transmitDelay:10
      helloMultiplier: 2
      mtuIgnore: true
      linkCost: 2
      drPriority: 2
    }
  }
  )
	{
    code
    success
    message
  }
}
```

### Removing an OSPF Configuration

```
mutation{
  removeOSPFConfig(
    removeOSPF:{
      instanceID: 0
      vrfName:"amzDefault"
      routerID:"1.1.1.1"
      logAdjacency:disabled
      spfDelay:10
      spfHoldtime: 20
      spfMaxHoldTime: 100
      rfc1583:false
      opaqueLSA:false
      maxMetric:false
      abrType:cisco
      defInfo:{
      	reDistributeDefault:false
        alwaysRedistribute:false
      }
    }
  )
	{
    code
    success
    message
  }
}
```

### Remvoing an OSPF Area Configurtion

```
mutation {
  removeOSPFAreaConfig(
    removeOSPFArea:{
      areaInfo:{uid:{id:1}}
    }
  ){
    code
    success
    message
  }
}
```

### Removing an OSPF Area Range Configuration

```
mutation {
  removeOSPFAreaRangeConfig(
    removeOSPFAreaRange:{
      areaInfo:{uid:{id:1}}
      rangePrefix:"32.0.0.0/8"
    }
  ){
    code
    success
    message
  }
}
```

### Remvoing an OSPF Interface Configuration

```
mutation{
  removeOSPFInterfaceConfig(removeOSPFInterface:{
    areaInfo:{
      uid:{id:4}
    },
    interfaceName: "ETH04"
  }){
    code
    message
    success
  }
}
```

## Queries


### Get an OSPF Configuration

```
query {
    network {
        getOSPFConfig {
            enabled
            ospfInst {
                routerID
                logAdjacency
                spfDelay
                spfHoldtime
                spfMaxHoldTime
                opaqueLSA
                rfc1583
                maxMetric
                stubRStartup
                stubRShutdown
                refBandwidth
                writeMultiplier
                abrType
                defInfo {
                    reDistributeDefault
                    alwaysRedistribute
                    metric
                    metricType
                    routeMap
                }
                distanceInfo {
                    all
                    intra
                    inter
                    external
                }
            }
        }
    }
}
```

### Get an OSPF Area Configuration

```
query {
    network {
        getOSPFAreas {
            vrfName
            instanceID
            areaInfo {
                __typename
                ... on AreaID {
                    id
                }
                ... on AreaIP{
                    address
                }
            }
            desc
            type
            nssaTranslatorRole
            defaultCost
            shortCut
            authType
            exportList
            importList
            filterListIn
            filterListOut
        }
    }
}
```

### Get an OSPF Areas

```
query {
    network {
        getOSPFAreas {
            vrfName
            instanceID
            areaInfo {
                __typename
                ... on AreaID {
                    id
                }
                ... on AreaIP{
                    address
                }
            }
            desc
            type
            nssaTranslatorRole
            defaultCost
            shortCut
            authType
            exportList
            importList
            filterListIn
            filterListOut
        }
    }
}
```

### Get an OSPF Area Ranges 

```
query getOSPFAreaRanges($areaInfo: AreaInfoInput) {
    network {
        getOSPFAreaRanges(areaInfo: $areaInfo) {
            instanceID
            vrfName
            areaInfo {
                __typename
                ... on AreaID {
                    id
                }
                ... on AreaIP{
                    address
                }
            }
            rangePrefix
            notAdvertise
            cost
            substitutePrefix
        }
    }
}
```

### Get an OSPF Interfaces 

```
query getOSPFInterfaces($areaInfo: AreaInfoInput) {
    network {
        getOSPFInterfaces(areaInfo: $areaInfo) {
            instanceID
            vrfName
            areaInfo {
                __typename
                ... on AreaID {
                    id
                }
                ... on AreaIP{
                    address
                }
            }
            interfaceName
            desc
            networkType
            authType
            authKey
            msgDigestKeyID
            msgDigestKey
            passiveInterface
            params {
                linkCost
                drPriority
                retransmitInterval
                transmitDelay
                helloInterval
                deadInterval
                helloMultiplier
                mtuIgnore
            }
        }
    }
}
```

### Get an OSPF Redistribution Configuration

```
query{
  network{
    getOSPFReDistributeConfig{
      enabled
      type
      metric
      metricType
      routeMap
      distributeList
    }
  }
}
```
