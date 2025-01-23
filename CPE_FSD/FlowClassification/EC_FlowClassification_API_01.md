# Schema

https://gitlab.amzetta.com/sdwan/zwan-cpe/blob/development/common/tegernsee/src/gql/network/modules/flowclassifier/schema.gql

# GRAPHQL Commands

## Mutations

### Add a Flow Classification rule

```
samples:

mutation { addFCRule (fcRule : {comment : \"smtp: rule for voice and video\", chain: \"NetBalancer\", seq: 1, fcProtocol : {protocol: 132}, fcTarget : {target: \"01:MPLS\"}, configuredState: Enabled}){code, message, success, fcRule { chain, seq, configuredState } } }

mutation { addFCRule (fcRule : {comment : \"complex rule\", chain: \"NetBalancer\", seq: 3, fcPacketHeader : { inputIfc: \"ETH02\", sourceIP : \"142.1.1.1\", destIP : \"162.1.1.1\", dscp : 9, fragments: true, packetMinLen: 1024, packetMaxLen: 4096, sourceMAC: \"02:aa:00:01:01:02\"}, fcProtocol : {protocol: 17, notProtocol: true, tcp : {sourcePort: \"1000-2000\", destPort: \"7890\", syn:true, ack: false, fin: true, rst: true, urg: true, psh: true, option: 7}},  fcConnectionState : {new: true, established: true, related: true, invalid: true, untracked: true, notConnectionState: true}, fcTime : {Sun: true, mon: true, tue: true, wed: true, thu: true, fri: true, sat: true, fromHH: 1, fromMM: 30, toHH: 2, toMM: 30},  fcDpi : {nDPI: \"apple\", notNDPI: false}, fcL7 : { l7Protocol: \"snmp\" , notL7Protocol: false}, fcConnectionLimit : {parallel : 10, parallelMoreLess: more, traffic : 1024, trafficUnit: "KB", trafficMoreLess: less}, fcLog : {logEnabled: true, logLimit: 10, logLimitSuffixDuration: Hour, logBurst: 3}, fcTarget : {target: \"01:MPLS\"}, configuredState: Enabled}){code, message, success, fcRule { chain, seq, configuredState } } }

```

### Delete a rule

```
mutation { deleteFCRule(chain: \"NetBalancer\", seq: 1){code, message, success } }
```

### Enable/Disable a rule

```
mutation { enableDisableFCRule(chain: \"NetBalancer\", seq: 1, configuredState: Enabled){code, message, success } }
```

## Queries


Rule Short List (sample)
```
query {network {fcRuleShort (chain: \"NetBalancer\") {chain, seq, ipt, isLogEnabled, target, configuredState } } }
query {network {fcRuleShort (chain: \"FORWARD\") {chain, seq, ipt, isLogEnabled, target, configuredState } } }
query {network {fcRuleShort (chain: \"QoS\") {chain, seq, ipt, isLogEnabled, target, configuredState } } }
```

Rule's detailed info

```
query {network {fcRule (chain: "NetBalancer", seq: 1) {fcPacketHeader {inputIfc, notInputIfc, outputIfc, notOutputIfc, sourceIP, notSourceIP, destIP, notDestIP, fragments, notFragments, packetMinLen, packetMaxLen, notLen, dscp, sourceMAC, notSourceMAC }, fcProtocol { protocol, notProtocol, tcp { sourcePort, notSourcePort, destPort, notDestPort, option, notOption, notTcpFlags, syn, ack, fin, rst, urg, psh}, udp { sourcePortUDP, notSourcePortUDP, destPortUDP, notDestPortUDP }, icmp { icmpType, notIcmpType } }, fcConnectionState {new, established, related, invalid, untracked, notConnectionState }, fcTime {fromHH, fromMM, toHH, toMM, mon, tue, wed, thu, fri, sat, sun}, fcDpi {nDPI, notNDPI}, fcL7 {l7Protocol, notL7Protocol}, fcConnectionLimit {parallel, parallelMoreLess, traffic, trafficMoreLess, trafficUnit}, fcLog {logEnabled, logLimit, logLimitSuffixDuration, logBurst}, fcTarget {forwardType, rejectWith, chainToJump, target}, chain, seq, comment, iptParams, ipt, configuredState  } } } 

```

List of input and output interface (ETH00, VPN etc) for flow classification

```
query {network {fcInterface} } 

```

List of IP Protocol name, its number and description"
```
query {network { fcIPProtocolDesc { protocolNumber, protocolName, protocolDescription } } } 
```

List of Deep Packet Inspection name and description

```
query {network { fcNDPIDesc { nDPIName, nDPIDescription } } } 
```

List of L7 Protocol name, description and its Pattern

```
query {network { fcL7ProtocolDesc { l7ProtocolName, l7ProtocolDescription, l7ProtocolPattern } } } 
```


