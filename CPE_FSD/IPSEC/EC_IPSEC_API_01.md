# Schema

Below link has the full schema for **IPSEC** module.

[IPSEC Schema](https://gitlab.amzetta.com/sdwan/zwan-cpe/blob/development/common/tegernsee/src/gql/network/modules/ipsec/schema.gql)

# GRAPHQL Commands

## Mutations:

### **Create** IPSEC Tunnel

```
curl -X POST http://10.11.251.173:8765/graphql -H "Content-Type: application/json"   -d '{ "query" : "mutation{ createIPsec( description: \"DC-BR2\", type: ESP, left: \"30.30.30.1\", right: \"30.30.30.3\", encrptionAlg: \"aes256\", integrityAlg: \"sha512\", dhGroup: \"modp4096\", lifeTime: \"1h\", ikeVersion: ikev2, ikeEncrptionAlg: \"aes256\", ikeIntegrityAlg: \"sha2_256\", ikeDHGroup: \"modp3072\", ikeLifetime: \"3h\", dpdDelay: \"30s\", dpdTimeout: \"150s\", dpdAction: restart, authType: X509, leftCert: \"00\", leftCertId: \"OU=SDWAN, CN=AMZDC, O=Amzetta, C=US, L=Norcross, ST=GA, N=EasyRSA, E=me@myhost.mydomain\" ) { code, success, message } }" }
```

### **Delete** IPSEC Tunnel

```
curl -X POST http://10.11.251.173:8765/graphql -H "Content-Type: application/json"   -d '{ "query" : "mutation{ deleteIPsec( tunnelName: \"IPSEC00\", vtiName: \"VTI00\" ){ code, success, message } }" }'
```

### **Disable** IPSEC Tunnel

```
curl -X POST http://10.11.251.173:8765/graphql -H "Content-Type: application/json"   -d '{ "query" : "mutation{ setIPsecState( tunnelName: \"IPSEC00\", state: down ){ code, success, message, status } }" }'
```

### **Enable** IPSEC Tunnel

```
curl -X POST http://10.11.251.173:8765/graphql -H "Content-Type: application/json"   -d '{ "query" : "mutation{ setIPsecState( tunnelName: \"IPSEC00\", state: up ){ code, success, message, status } }" }'
```

## Queries:

### **List** IPSEC Tunnel

```
curl -X POST http://10.11.251.173:8765/graphql -H "Content-Type: application/json"   -d '{ "query" : "{ network{ listIPsec{ tunnelName, description, vtiName, vtiKey, left, right, leftSubnet, rightSubnet, ikeVersion, ikeMode, ikeLifetime, ikeEncrptionAlg, ikeIntegrityAlg, ikeDHGroup, encrptionAlg, integrityAlg, dhGroup, lifeTime, dpdDelay, dpdTimeout, dpdAction, authType, secrets, leftCert, leftCertId, rightCertId, status, spi } } }" }'
```

### **Get** IPSEC Tunnel Info

```
curl -X POST http://10.11.251.173:8765/graphql -H "Content-Type: application/json"   -d '{ "query" : "{ network{ listIPsec(tunnelName: \"IPSEC00\") { tunnelName, description, vtiName, vtiKey, left, right, leftSubnet, rightSubnet, ikeVersion, ikeMode, ikeLifetime, ikeEncrptionAlg, ikeIntegrityAlg, ikeDHGroup, encrptionAlg, integrityAlg, dhGroup, lifeTime, dpdDelay, dpdTimeout, dpdAction, authType, secrets, leftCert, leftCertId, rightCertId, status, spi } } }" }'
```

### Get **Default** IPSEC Configuration

```
curl -X POST http://10.11.251.173:8765/graphql -H "Content-Type: application/json"   -d '{ "query" : "{ network{ getDefaultIPsecConfig{ type, allowAll, encrptionAlg, integrityAlg, dhGroup, lifeTime, ikeVersion, ikeMode, ikeEncrptionAlg, ikeIntegrityAlg, ikeDhGroup, ikeLifetime, dpdDelay, dpdTimeout, dpdAction, authType } } }" }'
```

### Get Supported **Encryption** List

```
curl -X POST http://10.11.251.173:8765/graphql -H "Content-Type: application/json"   -d '{ "query" : "{ network{ listEncryptionAlgorithm (ike: \"1\"){ id, value, ike } } }" }'
```

### Get Supported **Integrity Algorithm** List

```
curl -X POST http://10.11.251.173:8765/graphql -H "Content-Type: application/json"   -d '{ "query" : "{ network{ listIntegrityAlgorithm(ike: \"2\"){ id, value, ike } } }" }'
```

### Get Supported **DH Group** List

```
curl -X POST http://10.11.251.173:8765/graphql -H "Content-Type: application/json"   -d '{ "query" : "{ network{ listDHGroup(ike: \"1\"){ id, value, ike } } }" }'
```
