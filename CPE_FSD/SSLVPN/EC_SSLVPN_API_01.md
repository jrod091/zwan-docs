# Schema

https://gitlab.amzetta.com/sdwan/zwan-cpe/blob/development/common/tegernsee/src/gql/network/modules/vpn/schema.gql

# GRAPHQL API

## Mutations

### Create a SSL VPN tunnel

```
mutation{ createOpenVPN( description: \"BR1_to_BR3 via ISP1\", port: 10043, proto: UDP, role: Server, compression: false, encryption: true, parameters: \"\", authType: X509, gateway: \"Auto\", localIP: \"10.131.0.1\", certId: \"00\", certType: Imported ){ code, message, success } }
```

### Delete a SSL VPN tunnel

```
mutation{ deleteOpenVPN(name:\"VPN00\"){ code, message, success } }
```

## Queries

### List all SSL VPN tunnel

```
query { network {openVPNList {name, description, localIP, remoteIP, port, proto, role, compression, encryption, gateway, authType, psk, remoteCN, certType, parameters, vpnStatus, mac, multiClientServer, duplicateCN, cert {id, displayName, issuer{commonName}, status}, tapInterface {name, memberOf} } } }
query { network {openVPNList (name:"VPN01"){name, description, localIP, remoteIP, port, proto, role, compression, encryption, gateway, authType, psk, remoteCN, certType, parameters, vpnStatus, mac, multiClientServer, duplicateCN, cert {id, displayName, issuer{commonName}, status}, tapInterface {name, memberOf} } } }
```
