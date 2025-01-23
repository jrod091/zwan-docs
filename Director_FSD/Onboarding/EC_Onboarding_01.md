# Edge Controller Device Onboarding

## Overview: 

Edge Controller device must be associated to a Managed Service Provider (MSP). Onboarding process helps to securely associate the device to a particular MSP and establish a control path by creating a secure SSL tunnel between them. All orchestration activity happens through this control path. 

## Functionality:

### Edge Controller retrives MSP URL from Public Portal:
Edge Controller is identified by unique ID called PRODUCT_ID. PRODUCT_ID and Onboaring public portal URL will be updated into Edge Controller during Production. 
Edge Controller will connect to Onboarding public portal to retrive MSP information to which this device is assigned. Onboarding public portal give correct MSP Prodiver URL to Edge Controller to which it is associated. 

### Edge Controller updates the Key to MSP Provider:
Edge Controller use the MSP prodiver URL to connect to MSP and update its PRODUCT_ID. 
Once PRODUCT_ID is available in MSP, in MSP, this device is marked as 'Device Onboard Pending State'. 

### Edge Controller Onboarding:
Admin of the MSP must review this device and Onboard this unit. During onboard process, it creates SSL tunnel cert and tunnel key for the Edge Controller.
Edge Controller retrieve the Mgmt Tunnel information over a SSL connection.  Management tunnel information includes CA cert, tunnel host cert, tunnel private key, Tunnel ISP IP/Port etc.

### Edge Controller Secure Tunnel (Control Path):
Edge Controller will use the tunnel information and establish a secure SSL tunnel between Edge Controller and MSP. All the further communication between MSP and Edge Controller will happen through this tunnel.

## Configuration Parameters

As of now, Edge Controller get the PRODUCT_ID and MSP URL as part of initial device configuration. 

UI for onboard is pending. For now, Graphql API is used to view and onboard the edge controller.

1) List all the devices

curl -D- -X POST http://$MSP_IP:8080/api/auth/pre-auth -H 'content-type: application/json' -d '{"query" : "{ productID }" }'
```
query { productID }
```
2) Onboard the device:

curl -D- -X POST http://$MSP_IP:8080/api/auth/pre-auth -H 'content-type: application/json' -d '{"query" : "mutation{onboardProductByID(productID:\"PRODUCT_ID_001\",description:\"demo-dc\",description: \"Branch 1\", tunnel_ip:\"31.0.0.101\",tunnel_port:1194){code,success,message}}"}'

```
mutation {
      onboardProductKey (
       productKey: "PRODUCT_ID_001"
       description: "Branch 1"
       tunnel_ip: “10.131.0.101"
       tunnel_port: 4789
      ) {
         code
         success
         message
      }
}
```



## Known Limitations:
As of now, Edge Controller get the PRODUCT_ID and MSP URL as part of initial device configuration. 

## Future:
* Production server needs to be defined and implemented.
* UI for onboarding









