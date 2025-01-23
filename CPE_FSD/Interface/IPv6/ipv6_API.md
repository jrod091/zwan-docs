# Schema

https://172.16.120.65/sdwan/zwan-cpe/blob/release-0.1.0-diab/common/tegernsee/src/gql/network/modules/dhcp/schema.gql

# GRAPHQL Commands

*Set Local LAN IP*

curl -X POST http://$IP:$PORT/graphql -H "Content-Type: application/json"   -d '{ "query" : "mutation{ addIP( name: "WAN00", ip: { ipv4: { address: "2001:db8::3", prefixLength: "48", gateway:"2001:db8::1", dns: "2001:db8::10" } } ){ code, message, success } }" }'


## Mutations

*Add Static IP*

    mutation{
        addIP(name: \"WAN00\"
                ip: { 
                ipv6: {
                    address:\"2001:0db8:1234:5678::1\"
					prefixLength:\"48\"
					gateway: "2001:0db8:1234:5678::254\"
					dns:\"2001:0db8:abcd:ef01::10\"
                    } })
        {
            code
            message
            success
        }
    }

*Remove Static IP*

    mutation{
        removeIP(
            name: \"WAN00\"
            id: \"00\"){
        code
        success
        message
        }
    }
    

*Edit Static IP*

    mutation{
        modifyIP(name: \"WAN00\",
                id: \"00\",
                twampResponder:true,
                ip: { 
                ipv4: {
                    address:\"2001:0db8:1234:5678::1\"
					prefixLength:\"48\"
					gateway: "2001:0db8:1234:5678::254\"
					dns:\"2001:0db8:abcd:ef01::10\"
                    } })
        {
            code
            message
            success
        }
    }

*Set Interface state*

    mutation{
        setInterfaceState(name:\"WAN00\", status: true ){
            code
            success
            message
            interface{
            configuredStatus
            linkStatus
            }
        }
    }

*Enable DHCP IP*

    mutation{
        enableDHCPIP(name:\"WAN00\"){
            code
            message
            success
            interface{
                ipInfo{
                    ip{
                    __typename 
                    ... on IPv4Info {
                            ipv4: address
                                netmask
                        } 
                
                    ... on IPv6Info {
                            ipv6: address
                                prefixLength
                        } 
                    }
                    dhcp
                    id
                }
            name
            mac
            speed
            linkStatus
            }
        }
    }

*Release DHCP IP*

    mutation{
        releaseDHCPIP(name:\"WAN00\"){
            code
            message
            success
            interface{
            ipinfo{
                ip{
                __typename 
                ... on IPv4Info {
                        ipv4: address
                            netmask
                    } 
            
                ... on IPv6Info {
                        ipv6: address
                            prefixLength
                    } 
                }
                dhcp
                id
            }
            name
            mac
            speed
            status
            }
        }
    }

*Disable DHCP on interface*

    mutation{
        disableDHCPIP(name:\"WAN00\"){
            code
            message
            success
            interface{
            ipinfo{
                ip{
                __typename 
                ... on IPv4Info {
                        ipv4: address
                            netmask
                    } 
            
                ... on IPv6Info {
                        ipv6: address
                            prefixLength
                    } 
                }
                dhcp
                id
            }
            name
            mac
            speed
            status
            }
        }
    }

## Queries

    query {
        network {
            interfaces {
            ipInfo{
                ip{
                __typename 
                ... on IPv6Info {
                        address
                            netmask
							prefixLength
							gateway
							dns
                    } 
                }
                dhcp
                id
            }
            name
            mac
            speed
            linkStatus
            configuredStatus
            
            }
        }
    }

### LTE interface detail

    query  {
      network {
        interfaces {
        name
        interfaceType
        lteInfo {
           imei
           signal
           connectionState
           number
           apn
        }
        linkStatus
      	configuredStatus
        mtu
        memberOf
    	description
        speed
    	ipInfo{
            ip{
                __typename 
                ... on IPv4Info {
                        address
                            netmask
                    } 
                }
                dhcp
                id
            } 
        }
      }
    }
    
## Sample Curl command to get VLAN IPS for a particular LAN interface
    
curl -X POST http://127.0.0.1:8765/graphql -H "Content-Type:application/json" -d '{ "query" : "query {network {interfaces(name: \"LAN00\") {vlans {ipInfo {id,ip{... on IPv4Info{address,netmask}},dhcp,gateway} }}}}"}'