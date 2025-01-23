**Schema**

https://gitlab.amzetta.com/sdwan/zwan-cpe/blob/release-0.1.0-diab/common/tegernsee/src/gql/network/modules/dhcp/schema.gql

## GRAPHQL Commands

**Mutations**

*Create DHCP subnet*

    mutation {
        createDhcpSubnet( network:\"55.55.0.0\" netmask: \"255.255.0.0\") {
            code
            message
            success
        }
    }

*Update the DHCP subnet with DHCP server config paramters*

    mutation { 
       saveDhcpSubnet(subnetId:\"01\",
       ipRange:[{  start:\"55.55.1.50\" end:\"55.55.1.240\"}],
       defaultDuration:{days:1,hours:10 minutes:0} ,
       maxDuration:{days:10,hours:12,minutes:0},
       configuredStatus:true,
	   dns:[\"55.55.1.11\"],
  	   nis:\"55.55.1.12\",
  	   ntp:[\"55.55.1.13\"],
  	   wins:[\"55.55.1.14\"],
  	   domain:\"55.55.1.0\",
  	   gateway:\"55.55.1.10\")
       { 
         code,message,success,
         subnet {
	      	 subnetId,
 		     iface,
    	     network,
             netmask,
             configuredStatus,
             defaultDuration{days,hours,minutes}
             maxDuration{days,hours,minutes}
       	     ipRanges{start,end},
       		 dns, ntp, nis,
       		 wins, gateway, domain
  	        }
       }
    }

*Delete DHCP subnet*

    mutation
    {
        deleteDhcpSubnet( subnetId: \"01\") {
            code
            message
            success
        }
    }

*Add static IP to DHCP subnet*

    mutation{
    addStaticIPToDhcpSubnet(subnetId:\"00\",
            ip:\"75.75.3.110\",
            mac:\"AA:AB:AC:AD:AE:10\",
            description:\"testing45\")
    {
        code,
        message,
        success,
        subnet {
                subnetId,
                iface,
                network,
                netmask,
                configuredStatus,
                defaultDuration{days,hours,minutes}
                maxDuration{days,hours,minutes}
                ipRanges{start,end},
                    dns,
                    ntp,
                    nis,
                    wins,
                    gateway,
                    domain,
                    staticIP {
                        ip,
                        mac,
                        staticID,
                        description,
                        parameters
                    }
                }
            }
    }

*Remove static IP from subnet*

    mutation
    {
        removeStaticIPFromDhcpSubnet(
        subnetId:\"00\",staticID:\"1263207278_AAABACADAE10\")
        {
            code,
            message,
            success
        }
    }

*Edit static IP in DHCP subnet*

    mutation
    {
        editStaticIPInDhcpSubnet(subnetId:\"00\", 
                    staticID:\"1263207278_AAABACADAE10\",
                    ip:\"75.75.3.110\",
                    mac:\"AA:AB:AC:AD:AE:10\",
                    description:\"testing50edit\")
                    {
                        code,
                        message,
                        success,
                        subnet
                         {
                            subnetId,
                            iface,
                            network,
                            netmask,
                            configuredStatus,
                       defaultDuration{days,hours,minutes}
                       maxDuration{days,hours,minutes}
                       ipRanges{start,end},
                       dns,ntp,nis,
                       wins,gateway,domain,
                        staticIP {
                            ip,
                            mac,
                            staticID,
                            description,
                            parameters
                        }
                    }
        }
    }

**Queries**

*List available networks to create DHCP subnet*

    query {
        network{
            availableNetwork  
        }
    }

*List dhcp subnets*

     query {
        network{
            dhcpSubnets{ 
                subnetId,
                iface,
                network,
                netmask,
                configuredStatus,
                defaultDuration{days,hours,minutes}
                maxDuration{days,hours,minutes}
                ipRanges{start,end},
                dns,
                ntp,
                nis,
                wins,
                gateway,
                domain,
                staticIP {
                    ip,
                    mac,
                    staticID,
                    description,
                    parameters
                }
            }
        }
    }

*List the lease info table*

    query {
        network{
            leaseInfoTable(active:false)
            {
                hostname,
                ip,
                mac,
                state,
                startTime,
                endTime
            }
        }
    }
