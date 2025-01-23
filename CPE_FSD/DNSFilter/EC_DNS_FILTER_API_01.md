# DNS FILTER API's

API to list DNS filter list
```
curl -X POST http://127.0.0.1:8765/graphql -H "Content-Type:application/json" --max-time 600 -d '{ "query" : "query { network {  listDNSFilter(page:{offset:0, limit:50} ) {offset, limit, totalCount, result{filter_id,name} } } }"}'
```

API to save DNS filter config
```
curl -X POST http://127.0.0.1:8765/graphql -H "Content-Type: application/json"   -d '{ "query" : "mutation { saveDNSFilterConfig(config:{configStatus:true,defaultFilter:true,updateHour:23,type:refuse,urlPath:\"http://10.11.254.21/dnsfilter\"}){code, message, success} }" }'
```

API to enable DNS filter category/categories
```
curl -X POST http://127.0.0.1:8765/graphql -H "Content-Type: application/json"   -d '{ "query" : "mutation { enableDNSFilterSource(ids:[100,200,1037]){code, message, success} }" }'
```

API to disable DNS filter category/categories
```
curl -X POST http://127.0.0.1:8765/graphql -H "Content-Type: application/json"   -d '{ "query" : "mutation { disableDNSFilterSource(ids:[100,200,1037]){code, message, success} }" }'
```

API to list DNS filter custom allowlist
```
curl -X POST http://127.0.0.1:8765/graphql -H "Content-Type:application/json" --max-time 600 -d '{ "query" : "query { network {  getCustomDNSFilterAllowList(page:{offset:0, limit:50} ) {offset, limit, totalCount, result{domainID,domainName,description} } } }"}'
```

API to list DNS filter custom blocklist
```
curl -X POST http://127.0.0.1:8765/graphql -H "Content-Type:application/json" --max-time 600 -d '{ "query" : "query { network {  getCustomDNSFilterBlockList(page:{offset:0, limit:50} ) {offset, limit, totalCount, result{domainID,domainName,description} } } }"}'
```

API to list DNS filter custom allowlist
```
curl -X POST http://127.0.0.1:8765/graphql -H "Content-Type:application/json" --max-time 600 -d '{ "query" : "query { network {  getCustomDNSFilterAllowList(page:{offset:0, limit:50} ) {offset, limit, totalCount, result{domainID,domainName,description} } } }"}'
```


API to add domain to custom blocklist
```
curl -X POST http://127.0.0.1:8765/graphql -H "Content-Type: application/json"   -d '{ "query" : "mutation { addCustomDNSBlockListDomains(list:[{domainName:\"amazon.com\",description:\"amazon\"},{domainName:\"hindu.com\",description:\"Hindu news\"},{domainName:\"slickdeals.net\",description:\"Deals\"}]){code, message, success} }" }'
```

API to remove domain from custom blocklist
```
curl -X POST http://127.0.0.1:8765/graphql -H "Content-Type: application/json"   -d '{ "query" : "mutation { removeCustomDNSBlockListDomains(ids:[1,2,3]){code, message, success} }" }
```

API to add domain from custom allowlist
```
curl -X POST http://127.0.0.1:8765/graphql -H "Content-Type: application/json"   -d '{ "query" : "mutation { addCustomDNSAllowListDomains(list:[{domainName:\"amazon.com\",description:\"amazon\"},{domainName:\"hindu.com\",description:\"Hindu news\"},{domainName:\"slickdeals.net\",description:\"Deals\"}]){code, message, success} }" }
```


API to remove domain from custom allowlist
```
curl -X POST http://127.0.0.1:8765/graphql -H "Content-Type: application/json"   -d '{ "query" : "mutation { removeCustomDNSAllowListDomains(ids:[1,2,3]){code, message, success} }" }'
```


API to list details of category
```
curl -X POST http://127.0.0.1:8765/graphql -H "Content-Type:application/json" --max-time 600 -d '{ "query" : "query { network {  getDNSFilterConfig {configStatus,urlPath,updateHour,defaultFilter,filterPending,filterApplied,lastFilterPullTime,lastFilterReloadTime,timeToUpdateFilter} } }"}'| jq '.'
```

API to get details of DNS config
```
curl -X POST http://127.0.0.1:8765/graphql -H "Content-Type:application/json" --max-time 600 -d '{ "query" : "query { network {  getDNSConfig {domainName,configStatus,inputIface,memory,cpu,uptime,state} } }"}'| jq '.'
```

