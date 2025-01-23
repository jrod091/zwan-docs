# MAC FILTER API's

API to list filtered MAC's
```
curl -X POST http://127.0.0.1:8765/graphql -H "Content-Type:application/json" --max-time 600 -d '{ "query" : "query { network {  listFilteredMACs (page:{offset:0, limit:50} ) {offset, limit, totalCount, result } } }"}'  | jq '.'
```
API to get MAC filter config
```
curl -X POST http://127.0.0.1:8765/graphql -H "Content-Type:application/json" --max-time 600 -d '{ "query" : "query { network {getMacFilterConfig {configuredState} } }"}'  | jq '.'
```
API to update MAC filter config
```
curl -X POST http://127.0.0.1:8765/graphql -H "Content-Type: application/json"   -d '{ "query" : "mutation { updateMacFilterConfig(configuredState:true,action:ALLOW){code, message, success} }" }'
```
API to update MAC filter list
```
curl -X POST http://127.0.0.1:8765/graphql -H "Content-Type: application/json"   -d '{ "query" : "mutation { updateMacFilterList(macList:["02:00:ac:01:04:01"]){code, message, success} }" }'
```
API to update MAC filter config action to Deny
```
curl -X POST http://127.0.0.1:8765/graphql -H "Content-Type: application/json"   -d '{ "query" : "mutation { updateMacFilterConfig(configuredState:true,action:DENY){code, message, success} }" }'
```