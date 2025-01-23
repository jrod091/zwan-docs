# Schema

https://gitlab.amzetta.com/sdwan/zwan-cpe/blob/release-0.1.0-diab/common/tegernsee/src/gql/network/modules/netbalancer/schema.gql

# GRAPHQL  Commands

## Mutations

### Add a Load Balancer Gateway for BRANCH

```
mutation{ 
    addNBGateway(
        description:"BRANCH1-DC"
        type : BRANCH
        weight:1
        configuredStatus:UP
        destIP:"10.12.31.1"
        branchLan: "142.168.1.0/24"
        branchName: "AMZDC"
        timeoutCoefficient: 1 
    ){ 
        code, message, success 
    } 
}
```

### Add a Load Balancer Gateway for Internet breakout

```
mutation{ 
    addNBGateway(
        description:"INTERNET1", 
        type : INTERNET, 
        weight:1, 
        configuredStatus:UP, 
        destIP:"10.11.0.1", 
        timeoutCoefficient: 1 
    ){ 
        code, message, success 
    } 
}
```

### Update a Load Balancer Gateway

```
mutation{ updateNBGateway(description:"BRANCH1-DC", id:"02", type : BRANCH, weight:18, 
    configuredStatus:UP, destIP:"10.12.31.1",  timeoutCoefficient: 1, branchName:"AMZDC", branchLan: "142.168.1.0/24")
    { code, message, success } }
```

### Remove a Load Balancer Gateway

```
mutation{ removeNBGateway(id : "02"){ code, success, message } }
```


### Save Load balancer config for Branch
```
mutation{ 
    saveNetBalancerConfig(
        configuredStatus: Enabled,
        mode: LBFO, 
        icmpCheck: Enabled,
        probesUP:3, 
        probesDOWN:5, 
        icmpReplyTimeout:4, 
        pauseInterval:4, 
        pppdRestart:true, 
        foMonitorEnabledIP1: Disabled, 
        foMonitorEnabledIP2: Disabled,
        foMonitorEnabledIP3: Disabled, 
        type: BRANCH, 
        branchName:"AMZDC")
    {
        code, 
        message, 
        success 
    } 
}
```

### Save Load balancer config for Internet Breakout

```
mutation{ saveNetBalancerConfig(
        configuredStatus: Enabled,
        mode: LBFO,
        icmpCheck: Enabled, 
        probesUP:3, 
        probesDOWN:5, 
        icmpReplyTimeout:4,
        pauseInterval:4, 
        pppdRestart:true, 
        foMonitorEnabledIP1: Disabled, 
        foMonitorEnabledIP2: Disabled, 
        foMonitorEnabledIP3: Disabled,
        type: INTERNET)
    {
        code, 
        message, 
        success 
    } 
}
```

## Queries

### List all the Load balancer Configuration

```
query{ 
  network{
    netBalancer{
      mode
      configuredStatus
      runtimeStatus
      branchLan
      branchName
      foMonitor{
        icmpCheck
        runtimeStatus
        probesUP
        probesDOWN
        pauseInterval
        icmpReplyTimeout
        pppdRestart
        foMonitorEnabledIP1
        foMonitorEnabledIP2
        foMonitorEnabledIP3
      }
      nbGateways{
    	description
      weight
      configuredStatus
      linkStatus
      localInterface
      id
      destIP
      faults
        branchLan
        branchName
      }
    }
  }
}
```

### List all the Load Balancer Gateways

```
query{
  network{
    nbGateways{
      description
      weight
      configuredStatus
      linkStatus
      localInterface
      id
      destIP
      faults
     type
    }
  }
}
```
