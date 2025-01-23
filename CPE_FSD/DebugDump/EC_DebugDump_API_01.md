Schema

https://172.16.120.65/sdwan/zwan-cpe/blob/release-0.1.0-diab/common/tegernsee/src/gql/system/modules/debugdump/schema.gql


## GRAPHQL Commands

**Mutation**

    mutation {
    createDebugDump(uploadFTP:true, ftp:{ ftpServer:\"10.11.255.187\",userName:\"user2344\",password:\"password123@\"}) {
        code,
        message,
        success,
        dump
        
    }
    }