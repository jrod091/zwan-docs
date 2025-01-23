# GEO_FENCING TRUSTED MAC API's

Configure Geo-fencing with Trusted MAC address

```
 curl -X POST http://127.0.0.1:8765/graphql -H "Content-Type: application/json"   -d '{ "query" : "mutation {saveGeoFencingConfig(config:{configuredStatus: true,mac:{threshold:1,macList:[{macAddr:\"02:00:ac:01:04:01\",subnet:\"172.4.0.0/24\",description:\"4 network\",mandatory:false}, {macAddr:\"02:00:ac:01:04:02\",subnet:\"172.5.0.0/24\",description:\"5 network\",mandatory:true}]}}){code, message, success} }" }'
```

Configure Geo-fencing with GPS Location 

```
 curl -X POST http://127.0.0.1:8765/graphql -H "Content-Type: application/json"   -d '{ "query" : "mutation {saveGeoFencingConfig( config:{configuredStatus: true, gps:{longitude:\"-84.187317\", latitude:\"33.920471\", fence:false, distance:1, inKilometers:true } } ) {code, message, success} }" }'
```

Configure Geo-fencing with Trusted MAC address and GPS Location 

```
 curl -X POST http://127.0.0.1:8765/graphql -H "Content-Type: application/json"   -d '{ "query" : "mutation {saveGeoFencingConfig( config:{configuredStatus: true, mac:{threshold:1,macList:[{macAddr:\"02:00:ac:01:04:01\",subnet:\"172.4.0.0/24\",description:\"4 network\",mandatory:false}, {macAddr:\"02:00:ac:01:04:02\",subnet:\"172.5.0.0/24\",description:\"5 network\",mandatory:true}]},gps:{longitude:\"-84.187317\", latitude:\"33.920471\", fence:false, distance:1, inKilometers:true } } ) {code, message, success} }" }'
```
Get Geo fencing config 

```
curl -X POST http://127.0.0.1:8765/graphql -H "Content-Type: application/json"   -d '{ "query" : "query { network { getGeoFencingConfig {action,config{configuredStatus, mac { threshold, macList { macAddr,subnet,description,mandatory}}, gps {longitude, latitude, fence, distance, inKilometers}}, gpsCurrLocation{longitude, latitude} }} }" }'
```

Disable geo-fencing config

```
curl -X POST http://127.0.0.1:8765/graphql -H "Content-Type: application/json"   -d '{ "query" : "mutation {saveGeoFencingConfig(config:{configuredStatus: false}){code, message, success} }" }'
```
List Available LANMac Address

```
curl -X POST http://127.0.0.1:8765/graphql -H "Content-Type:application/json" --max-time 600 -d '{ "query" : "query { network { listAvailableLANMacAddress {status, macs {macAddress,subnet}}} }" }'
```

Discover LAN MAC addresss

```
curl -X POST http://127.0.0.1:8765/graphql -H "Content-Type: application/json"   -d '{ "query" : "mutation {discoverLANMacAddress{code, message, success} }" }'
```


