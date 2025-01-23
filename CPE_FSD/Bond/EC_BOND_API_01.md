**Schema**

https://gitlab.amzetta.com/sdwan/zwan-cpe/blob/release-0.1.0-diab/common/tegernsee/src/gql/network/modules/bond/schema.gql

## GRAPHQL Commands

**Mutations**

*Create Bond*

    mutation{
        createBond( description : \"bond101\"
                     interfacesInfo:  [ 
                         { name: \"ETH01\"} 
                         { name: \"ETH02\"} ] ,
                        mode:FAILOVER_ONLY,
                        primary:\"ETH02\"){
            code
            success
            message
            bond {
                name
                description
                primary
                ifacesInfo{
                    name
                }
                
            }
        }
    } 

*Delete Bond*

    mutation{
        deleteBond( name:\"BOND00\"){
            code
            success
            message
        }
    } 


*Edit/Modify Bond*

    mutation{
        createBond( description : \"bond101\"
                     interfacesInfo:  [ 
                         { name: \"ETH01\"} 
                         { name: \"ETH02\"} ] ,
                        mode:LOAD_BALANCING_AND_FAILOVER,
                        primary:\"ETH02\"){
            code
            success
            message
            bond {
                name
                description
                primary
                ifacesInfo{
                    name
                }
                
            }
        }
    }

**Queries**

*List Bonds*

    query {
        network{
            bonds{
                name
                description
                primary
                mode
                ifacesInfo{
                name
                }
            }
        }
    }


