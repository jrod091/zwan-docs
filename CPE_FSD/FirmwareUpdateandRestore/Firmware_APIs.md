## Schema

https://gitlab.amzetta.com/sdwan/zwan-cpe/-/blob/development/common/tegernsee/src/gql/system/modules/firmware/schema.gql
 
 ## *GraphQL APIs*  -Mutation
   
# Patch Update
 ## [GRAPHQL Command]

 curl -X POST http://127.0.0.1:8765/graphql -H "Content-Type:application/json" -d '{ "query" : "mutation { updateFW( updateInfo: { protocol: \"'${PROTOCOL}'\", server_name: \"'${UP_SERVER}'\", server_port: \"'${UP_PORT}'\", urlPath: \"'${URL_PATH}'\", filename: \"'${FILENAME}'\", backup: '${BACKUP}', username: \"'${USERNAME}'\", password: \"'${PASSWORD}'\", md5sum: \"'${MD5SUM}'\" }) {code,success,message} }" }'
 ```sh
 "mutation 
       {
  updateFW: {
    updateInfo: {
      protocol: `${PROTOCOL}`,
      server_name: `${UP_SERVER}`,
      server_port: `${UP_PORT}`,
      urlPath: `${URL_PATH}`,
      filename: `${FILENAME}`,
      backup: `${BACKUP}`,
      username: `${USERNAME}`,
      password: `${PASSWORD}`,
      md5sum: `${MD5SUM}`
    }
  }
}
 ```

# Firmware Recovery
## [GRAPHQL Command]

 curl -X POST http://127.0.0.1:8765/graphql -H "Content-Type:application/json" -d '{ "query" : "mutation { restoreFW( restoreInfo: { img_chkpt: \"'${IMG_CHKPT}'\", conf_chkpt: \"'${CONF_CHKPT}'\" }) {code,success,message} }" }'
 
 ```sh
 mutation {
        restoreFW(restoreInfo: { img_chkpt: "'${IMG_CHKPT}'", conf_chkpt: "'${CONF_CHKPT}'" }) {
    code
    success
    message
  }
}
 ```


# Factory Reset
## [GRAPHQL Command]

 curl -X POST http://127.0.0.1:8765/graphql -H "Content-Type:application/json" -d '{ "query" : "mutation { factoryResetFW{code,success,message} }" }'
 ```sh
 mutation {
  factoryResetFW {
    code
    success
    message
  }
}
 ```

