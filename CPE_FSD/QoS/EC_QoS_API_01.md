# Schema

https://gitlab.amzetta.com/sdwan/zwan-cpe/blob/development/common/tegernsee/src/gql/network/modules/qos/schema.gql

# GraphQL API

## Mutations

### Class Manager:
#### Create a class manager

```
mutation { createClassManager ( classManager : { cmName : \"CM1\", description: \"CM1_Desc\", priority: Low, dscp: 4, maxBandwidth: 100,  maxBandwidthUnit: MBits_per_sec,  guaranteedBandwidth: 200,  guaranteedBandwidthUnit:  KBits_per_sec}) {code, message, success,  classManager { cmName, description, configuredState, dscp, maxBandwidth, guaranteedBandwidth } } }
```

#### Enabled/Disable a Class Manager CPE wide

```
mutation { enableDisableClassManager ( cmName : \"CM1\", configuredState : Enabled) {code, message, success  } }
```


#### Remove  a Class Manager
```
mutation { removeClassManager ( cmName : \"CM1\") {code, message, success  } }
```


### QoS Interface:

#### Add a Class Manager to Interface
```
mutation { addClassManagerToInterface ( ifcName : \"ETH03\", cmName : \"CM1\") {code, message, success, qosInterface { ifcName, linkStatus, description, memberOf, memberList, maxBandwidth, maxBandwidthUnit, guaranteedBandwidth, guaranteedBandwidthUnit, total_guaranteed_allocated, total_guaranteed_allocated_percent, classManagerList { cmName, description, configuredState, isLocal, dscp, priority, isActive } }  } }
```

#### Delete a Class Manager from Interface
```
mutation { deleteClassManagerFromInterface ( ifcName : \"ETH03\", cmName : \"CM1\") {code, message, success  } }
```

#### Edit Local Class Manager (not the Class manager template) of Interface
```
mutation { editLocalClassManagerOfInterface ( ifcName : \"ETH03\", ifcClassManager : { cmName : \"CM1\", isLocal: true, priority: Low, maxBandwidth: 1000, maxBandwidthUnit : MBits_per_sec,  guaranteedBandwidth: 500, guaranteedBandwidthUnit : MBits_per_sec, dscp: 9}) {code, message, success, qosInterface { ifcName, linkStatus, description, memberOf, memberList, maxBandwidth, maxBandwidthUnit, guaranteedBandwidth, guaranteedBandwidthUnit, total_guaranteed_allocated, total_guaranteed_allocated_percent, classManagerList { cmName, description, configuredState, isLocal, dscp, priority, isActive } }  } }
```

#### Enable/Disable Class Manager within a Interface
```
mutation { enableDisableClassManagerInInterface ( ifcName : \"ETH003\", cmName: \"CM1\", configuredState: Disabled ) {code, message, success  } }
```

### QoS Global config:

#### Set Bandwidth for Interface
```
mutation { editQoSBandwidthOfInInterface ( qosInterface : { ifcName : \"ETH003\", maxBandwidth: 1000, maxBandwidthUnit : MBits_per_sec, guaranteedBandwidth: 600, guaranteedBandwidthUnit : MBits_per_sec } ) {code, message, success  } }
```


#### Enable/Disable whole QoS  for an Interface
```
mutation { enableDisableQoSOfInInterface ( ifcName : \"ETH03\", configuredState: Enabled ) {code, message, success  } }
```

#### Activate all changes made for all Interface
```
mutation { activateQoSChangesForCPE ( dummy: \"dummy\" ) {code, message, success  } }
```


## Queries

### Class Manager

```
query { network  { classManager {cmName, description, priority, dscp, maxBandwidth, maxBandwidthUnit, guaranteedBandwidth, guaranteedBandwidthUnit, configuredState } } }

query { network  { classManager (cmName: \"DEFAULT\"){cmName, description, priority, dscp, maxBandwidth, maxBandwidthUnit, guaranteedBandwidth, guaranteedBandwidthUnit, configuredState } } }
```


### QoS Interface

```
query { network  { qosInterface  {ifcName, linkStatus, description, memberOf, memberList, maxBandwidth, maxBandwidthUnit, guaranteedBandwidth, guaranteedBandwidthUnit, configuredState, total_guaranteed_allocated, total_guaranteed_allocated_percent, is_activation_needed, classManagerList { cmName, description, isLocal, priority, dscp, maxBandwidthWithUnit, guaranteedBandwidthWithUnit, configuredState, isActive  } } } }

query { network  { qosInterface  (ifcName: \"ETH03\") {ifcName, linkStatus, description, memberOf, memberList, maxBandwidth, maxBandwidthUnit, guaranteedBandwidth, guaranteedBandwidthUnit, configuredState, total_guaranteed_allocated, total_guaranteed_allocated_percent, is_activation_needed, classManagerList { cmName, description, isLocal, priority, dscp, maxBandwidthWithUnit, guaranteedBandwidthWithUnit, configuredState, isActive  } } } }
```


