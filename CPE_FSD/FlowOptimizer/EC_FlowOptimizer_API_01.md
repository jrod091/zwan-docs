# Schema

https://gitlab.amzetta.com/sdwan/zwan-cpe/blob/development/common/tegernsee/src/gql/network/modules/flowclassifier/schema.gql

# GraphQL API

## Mutations

### Create a flow classification rule with flow optimizer parameters

```
mutation { addFCRule (fcRule : {comment : "rule for voice and video", chain: "NetBalancer", seq: 1, configuredState: Enabled, fcProtocol : {protocol: 132}, fcTarget : {target: "01", isAutoFlowControl:true, flowOptimizer : {flowOptiMethod : PERFORMANCE, performance : { latency : true, latencyWeight : 9, latencyReqdLessthan : 25, jitter : true, jitterWeight:5, jitterReqdLessthan : 10, packetLoss: true, packetLossWeight: 1, packetLossReqdLessthan: 10} } } } ) {code, message, success, fcRule { chain, seq, configuredState } } }

```

## Queries


```
query {network {fcRule (chain: "NetBalancer", seq: 1) {fcTarget {forwardType, rejectWith, chainToJump, target, isAutoFlowControl, flowOptimizer {flowOptiMethod, performance {latency, latencyWeight, latencyReqdLessthan, jitter, jitterWeight, jitterReqdLessthan, packetLoss, packetLossWeight, packetLossReqdLessthan}, pathAffinity{pathOrder}, bandwidth{minBandwidth}, cost{maxCost}} }, chain, seq, comment, iptParams, ipt, configuredState  } } } 

```


