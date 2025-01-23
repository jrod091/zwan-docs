# Schema

https://gitlab.amzetta.com/sdwan/zwan-cpe/blob/release-0.1.0-diab/common/tegernsee/src/gql/network/modules/webfilter/schema.gql


# GRAPHQL API

## Mutations

### Add an IPSet Table

```
mutation{
  addIPSetTable(
    addIPSet:{ name: "amzetta",  desc: "amzetta" } )
  {
    code
    message
    success
    ipSet{name, desc}
  }
}
```
### Add an IPSet Entry

```
mutation{
  addIPSetEntry(
    addIPSetEntry:{ 
      name:"amzetta", 
        ip:{ipv4:{address:"45.40.146.28"}}, 
        desc:" entry 1"
    } ) 
  {
    code
    message
    success
    ipSetEntries{
      seq, 
        ip {
          __typename
          ... on 
          	IPv4Info {
          		address,
        	}          
        }, 
        desc
    }
  }
}
```

### Add an array of IPSet entries. 

```
mutation { 
    addIPSetEntriesArray ( 
        ipSetEntriesList:{ 
            name:"ipsetArray", 
            ip:[ "2.2.2.2-2.2.2.6", "1.1.1.1" ]
        } 
    )
    { 
        code 
        success 
        message 
    }
}
```

### Bulk addition of IPSet Entries 

```
mutation {  
    setIPSet ( 
        ipSetEntriesList:{ 
            name:"ipsetArray", 
            ip:[ "2.2.2.2-2.2.2.6", "1.1.1.1" ]
        } 
    )
    { code 
        success 
        message 
    }
}
```

### Add FC Rule with an IPSet 

```
mutation {  
    addFCRule(
        fcRule:{ comment:"FirewallIPSetTest", chain:"ZWAN_OUTPUT", seq:1, 
            fcPacketHeader:{ destIPSet:"amzetta" }, 
            fcTarget:{ target:"DROP" }, 
            configuredState:Enabled 
        } 
    )  
    { 
        code 
        message 
        success 
        fcRule { 
            chain 
            seq 
            configuredState 
        } 
    } 
}
```

### Delete an IPSet Entry

```
mutation{
  deleteIPSetEntry(
    deleteIPSetEntry:{ 
      name:"amzetta", 
      seq: 2
    } ) 
  {
    code
    message
    success
    ipSetEntries{
      seq, 
        ip {
          __typename
          ... on IPv4Info {
          	    address
        	}          
        } 
        desc
    }
  }
}
```

### Delete an array of IPSet entries. 

```
mutation {  
    deleteIPSetEntriesArray ( 
        ipSetEntriesList:{ 
            name:"ipsetArray", 
            ip:[ "2.2.2.2-2.2.2.6", "1.1.1.1" ]
        } 
    )
    { 
        code 
        success 
        message 
    }
}
```

### Delete an IPSet Table

```
mutation{
 deleteIPSetTable(
  	deleteIPSet:{ name: "amzetta",  desc: " " } )
  {
    code
    message
    success

  }
}
```

## Queries

### Get list of IPSet Entries

```
query{
  network{
    listIPSetEntries(name:"amzetta"){
     seq,
     ip {
          __typename
          ... on 
          	IPv4Info {
          		address,
        	}          
        },
        desc
      }
   }
}
```

### Get list of all the IPSetLists

```
query{
  network{
    listIPSetLists{name, desc}
	}
}
```
