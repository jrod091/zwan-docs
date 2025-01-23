# Schema

https://gitlab.amzetta.com/sdwan/zwan-cpe/blob/release-0.1.0-diab/common/tegernsee/src/gql/network/modules/ipfilter/schema.gql

# GRAPHQAL  Commands

## Mutations

### Add a Prefix filter table

```
mutation{ createFilterTable(createFilter:{name: \"as200In\", desc: \"as200In\", type:prefix}){code,message, success }}
```

### Add a Prefix entry to an existing table

```
mutation{ addPrefixEntry(addPrefix:{name:\"as200In\", action: permit, prefix: \"200.2.0.0/16\"}){ code,message,success, prefixList{action,le, ge, prefix, seq }}}
```

### Add an Access filter table

```
mutation{ createFilterTable( createFilter: {name: \"myAggregate\", desc: \"myAggregate\", type:access}){code,message,success}}
```
### Add an Access entry to an existing table

```
mutation{ addAccessEntry(addAccess:{name: \"myAggregate\", action: permit, IPNetwork: \"100.1.0.0/16\"}){code,message,success,accessList{ action, IPNetwork, seq }}}
```

## Queries

### List access and prefix filter tables

```
query { network { listFilterTables { access { name, desc } prefix { name, desc } } } }
```

### List Access entries

```
query { network { listAccessEntries(name: \"myAggregate\"){ action, IPNetwork, seq } } }
```

### List Prefix entries

```
query { network { listPrefixEntries(name: \"as200In\"){ action, prefix, seq, le, ge  }  }
```