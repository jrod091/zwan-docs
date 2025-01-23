**Schema**

https://172.16.120.65/sdwan/zwan-cpe/blob/development/common/tegernsee/src/gql/network/modules/utilities/schema.gql

**GRAPHQL API**

**Mutations**

*DNS lookup*

    mutation{
    dnsLookup(source:\"10.11.255.26\", destination:\"amazon.com\" ){
        code
        success
        message
        output
    }

*Ping*

    mutation{
        ping(destination: \"40.40.40.1\" size: 64){
            code
            success
            message
            output
        }
    }

*ARP Check*

    mutation{
        arpCheck(destination: \"10.11.0.1\"){
            code
            success
            message
            output
        }
    }


*Tracepath*

    mutation{
        tracePath(destination: \"10.11.0.1\"){
            code
            success
            message
            output
        } 
    }