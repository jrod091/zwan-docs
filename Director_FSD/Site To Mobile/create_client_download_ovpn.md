# Create clients and download ovpn files
 - Download the files from [Scripts](https://gitlab.amzetta.com/sdwan/zwan-doc/-/tree/zid-smtp-bulk-user/Director_FSD%2Fsite-to-mobile%2Fscripts) (Skip this step if already downloaded).
 - Update the values in .env file
 
        ``` 
            DIRECTOR_IP=<director_ip>
            TENANT_REALM_NAME=<tenant_realm_name>
            TENANT_LOGIN_USER=<login_user>
            TENANT_LOGIN_PASSWORD=<login_password>

            COUNTRY_CODE=IN
            STATE=TN
            CITY=Chennai
            ORGANIZATION=Amzetta
            ORGANIZATIONAL_UNIT=sdwan
            #VPN Server details
            SERVER_IP_PORT=[\"x.x.x.x:10001\",\"x.x.x.x:10001\"]
        ```
 - Run the create-client.sh script on the director host machine. This script reads user details from an Excel sheet and creates clients in tenant realm.
 - To download the ovpn files for users, We should run download-ovpn.sh script on the director host machine, This script will download the ovpn conf files for all clients and stored in current directory.