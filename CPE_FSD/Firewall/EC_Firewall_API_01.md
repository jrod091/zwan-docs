# Schema

https://gitlab.amzetta.com/sdwan/zwan-cpe/blob/development/common/tegernsee/src/gql/network/modules/flowclassifier/schema.gql

# GraphQL API


## Mutation

### Firewall Chain

#### Add Custom Chain
```
mutation{ addFWChain( chain: \"customchain\"){ code, message, success } }
```

#### Delete Custom Chain
```
mutation{ removeFWChain( chain: \"customchain\"){ code, message, success } }
```

#### Enable/disable Chain
```
mutation{ enabledisableFWChain ( chain: \"customchain\", isEnabled: true){ code, message, success } }
```

#### Change Default Policy for inbuilt Chain (INPUT/OUTPUT/FORWARD)
```
mutation{ changeChainDefaultPolicy ( changePolicy : {chain : \"FORWARD\", defaultPolicy: \"DROP\"} ) { code, message, success } }
```

### Firewall rule

#### Add Firewall Rule
```
mutation { addFCRule (fcRule : { comment : "DPI APPLE ACCEPT", chain: "FORWARD", seq: 3, fcDpi : {nDPI: "apple", notNDPI: false}, fcTarget : {target: "ACCEPT"}, configuredState: Enabled}){code, message, success, fcRule { chain, seq, configuredState } } }
mutation { addFCRule (fcRule : {comment : \"complex rule\", chain: \"FORWARD\", seq: 3, fcPacketHeader : { inputIfc: \"ETH03\", sourceIP : \"142.1.1.1\", destIP : \"162.1.1.1\", dscp : 9, fragments: true, packetMinLen: 1024, packetMaxLen: 4096, sourceMAC: \"02:aa:00:01:01:02\"}, fcProtocol : {protocol: 17, notProtocol: true, tcp : {sourcePort: \"1000-2000\", destPort: \"7890\", syn:true, ack: false, fin: true, rst: true, urg: true, psh: true, option: 7}},  fcConnectionState : {new: true, established: true, related: true, invalid: true, untracked: true, notConnectionState: true}, fcTime : {Sun: true, mon: true, tue: true, wed: true, thu: true, fri: true, sat: true, fromHH: 1, fromMM: 30, toHH: 2, toMM: 30}, fcDpi : {nDPI: \"apple\", notNDPI: false}, fcL7 : { l7Protocol: \"snmp\" , notL7Protocol: false}, fcConnectionLimit : {parallel : 10, parallelMoreLess: more, traffic : 1024, trafficUnit: \"KB\", trafficMoreLess: less}, fcLog : {logEnabled: true, logLimit: 10, logLimitSuffixDuration: Hour, logBurst: 3}, fcTarget : {target: \"ACCEPT\"}, configuredState: Enabled}){code, message, success, fcRule { chain, seq, configuredState } } }
```

#### Delete Firewall Rule
```
mutation { deleteFCRule(chain: \"FORWARD\", seq: 1){code, message, success } }
```

#### Enable/Disable a Firewall rule
```
mutation { enableDisableFCRule(chain: \"FORWARD\", seq: 1, configuredState: Enabled){code, message, success } }
```


## Query

### Firewall Chain List
query { network { fcListChains { chain, isEnabled, defaultPolicy, policyList } } }
 
### Firewall rule List

Short List

```
query {network {fcRuleShort (chain: \"INPUT\")   {chain, seq, ipt, isLogEnabled, target, configuredState } } }
query {network {fcRuleShort (chain: \"FORWARD\") {chain, seq, ipt, isLogEnabled, target, configuredState } } }
query {network {fcRuleShort (chain: \"OUTPUT\")  {chain, seq, ipt, isLogEnabled, target, configuredState } } }
```

Detailed List

```
query {network {fcRule (chain: \"INPUT\",   seq: 1) {fcPacketHeader {inputIfc, notInputIfc, outputIfc, notOutputIfc, sourceIP, notSourceIP, destIP, notDestIP, fragments, notFragments, packetMinLen, packetMaxLen, notLen, dscp, sourceMAC, notSourceMAC }, fcProtocol { protocol, notProtocol, tcp { sourcePort, notSourcePort, destPort, notDestPort, option, notOption, notTcpFlags, syn, ack, fin, rst, urg, psh}, udp { sourcePortUDP, notSourcePortUDP, destPortUDP, notDestPortUDP }, icmp { icmpType, notIcmpType } }, fcConnectionState {new, established, related, invalid, untracked, notConnectionState }, fcTime {fromHH, fromMM, toHH, toMM, mon, tue, wed, thu, fri, sat, sun}, fcDpi {nDPI, notNDPI}, fcL7 {l7Protocol, notL7Protocol}, fcConnectionLimit {parallel, parallelMoreLess, traffic, trafficMoreLess, trafficUnit}, fcLog {logEnabled, logLimit, logLimitSuffixDuration, logBurst}, fcTarget {forwardType, rejectWith, chainToJump, target}, chain, seq, comment, iptParams, ipt, configuredState  } } } 
query {network {fcRule (chain: \"FORWARD\", seq: 1) {fcPacketHeader {inputIfc, notInputIfc, outputIfc, notOutputIfc, sourceIP, notSourceIP, destIP, notDestIP, fragments, notFragments, packetMinLen, packetMaxLen, notLen, dscp, sourceMAC, notSourceMAC }, fcProtocol { protocol, notProtocol, tcp { sourcePort, notSourcePort, destPort, notDestPort, option, notOption, notTcpFlags, syn, ack, fin, rst, urg, psh}, udp { sourcePortUDP, notSourcePortUDP, destPortUDP, notDestPortUDP }, icmp { icmpType, notIcmpType } }, fcConnectionState {new, established, related, invalid, untracked, notConnectionState }, fcTime {fromHH, fromMM, toHH, toMM, mon, tue, wed, thu, fri, sat, sun}, fcDpi {nDPI, notNDPI}, fcL7 {l7Protocol, notL7Protocol}, fcConnectionLimit {parallel, parallelMoreLess, traffic, trafficMoreLess, trafficUnit}, fcLog {logEnabled, logLimit, logLimitSuffixDuration, logBurst}, fcTarget {forwardType, rejectWith, chainToJump, target}, chain, seq, comment, iptParams, ipt, configuredState  } } } 
query {network {fcRule (chain: \"OUTPUT\",  seq: 1) {fcPacketHeader {inputIfc, notInputIfc, outputIfc, notOutputIfc, sourceIP, notSourceIP, destIP, notDestIP, fragments, notFragments, packetMinLen, packetMaxLen, notLen, dscp, sourceMAC, notSourceMAC }, fcProtocol { protocol, notProtocol, tcp { sourcePort, notSourcePort, destPort, notDestPort, option, notOption, notTcpFlags, syn, ack, fin, rst, urg, psh}, udp { sourcePortUDP, notSourcePortUDP, destPortUDP, notDestPortUDP }, icmp { icmpType, notIcmpType } }, fcConnectionState {new, established, related, invalid, untracked, notConnectionState }, fcTime {fromHH, fromMM, toHH, toMM, mon, tue, wed, thu, fri, sat, sun}, fcDpi {nDPI, notNDPI}, fcL7 {l7Protocol, notL7Protocol}, fcConnectionLimit {parallel, parallelMoreLess, traffic, trafficMoreLess, trafficUnit}, fcLog {logEnabled, logLimit, logLimitSuffixDuration, logBurst}, fcTarget {forwardType, rejectWith, chainToJump, target}, chain, seq, comment, iptParams, ipt, configuredState  } } } 
```
