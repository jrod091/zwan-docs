#!/bin/bash

source ./.env

# Check if curl is installed
if ! command -v curl &> /dev/null; then
    echo "curl is not installed. Installing..."
    sudo apt-get update
    sudo apt-get install curl
else
    echo "curl is already installed."
fi

# Check if jq is installed
if ! command -v jq &> /dev/null; then
    echo "jq is not installed. Installing..."
    sudo apt-get update
    sudo apt-get install -y jq
    if [ $? -eq 0 ]; then
        echo "jq installation successful!"
    else
        echo "Failed to install jq. Please install it manually."
        exit 1
    fi
else
    echo "jq is already installed."
fi

# Install xlsx2csv package
if ! command -v xlsx2csv &> /dev/null; then
    echo "xlsx2csv is not installed. Installing..."
    sudo apt-get update
    sudo apt-get install xlsx2csv
    if [ $? -eq 0 ]; then
        echo "xlsx2csv installation successful!"
    else
        echo "Failed to install xlsx2csv. Please install it manually."
        exit 1
    fi
else
    echo "xlsx2csv is already installed."
fi


xlsx2csv users.xlsx > output.csv

TOKEN_URL='https://'$DIRECTOR_IP':8082/auth/realms/'$TENANT_REALM_NAME'/protocol/openid-connect/token'

response=$(curl -k --location "$TOKEN_URL" \
    --header 'Content-Type: application/x-www-form-urlencoded' \
    --data-urlencode 'grant_type=password' \
    --data-urlencode 'client_id='$TENANT_REALM_NAME-client'' \
    --data-urlencode 'client_secret=secret' \
    --data-urlencode 'username='$TENANT_LOGIN_USER'' \
    --data-urlencode 'password='$TENANT_LOGIN_PASSWORD'' \
    -w "%{http_code}" -o response.json)

http_code=$(echo "$response" | tail -c 4)
echo "Token http code: " $http_code
if [ "$http_code" -eq 200 ]; then
    token=$(jq -r '.access_token' response.json)
    echo "token: " $token

    get_access_token=$(curl -k --location "$TOKEN_URL" \
    --header "Authorization: Bearer $token" \
    --header 'Content-Type: application/x-www-form-urlencoded' \
    --data-urlencode 'grant_type=urn:ietf:params:oauth:grant-type:uma-ticket' \
    --data-urlencode 'audience='$TENANT_REALM_NAME-client'' \
    --data-urlencode 'permission=certificate-service' \
    -w "%{http_code}" -o response.json)
    http_code=$(echo "$get_access_token" | tail -c 4)
    echo "get_access_token http code: " $http_code
    token=$(jq -r '.access_token' response.json)

    if [ "$http_code" -eq 200 ]; then
        while IFS=, read -r col1 col2 col3
            do
                FIRSTNAME=$col1
                LASTNAME=$col2
                clientName=$FIRSTNAME$LASTNAME
                EMAIL=$col3    
                echo "COUNTRY_CODE: $COUNTRY_CODE"
                echo "STATE: $STATE"
                echo "CITY: $CITY"
                echo "ORGANIZATION: $ORGANIZATION"
                echo "ORGANIZATIONAL_UNIT: $ORGANIZATIONAL_UNIT"
                echo "SERVER_IP_PORT: $SERVER_IP_PORT"

                payload='{"operationName":"createMobileClient","variables":{"mobileClient":{"clientName":"'"$clientName"'","countryCode":"'"$COUNTRY_CODE"'","state":"'"$STATE"'","city":"'"$CITY"'","organization":"'"$ORGANIZATION"'","email":"'"$EMAIL"'","organizationalUnit":"'"$ORGANIZATIONAL_UNIT"'","serverIPPorts":'"$SERVER_IP_PORT"',"userAuthEnabled":true}},"query":"mutation createMobileClient($mobileClient: MobileClientInput!) {\n  createMobileClient(mobileClient: $mobileClient) {\n    code\n    success\n    message\n    __typename\n  }\n}\n"}'
                url='https://'$DIRECTOR_IP'/'$TENANT_REALM_NAME'/api/certificate-service/graphql'
                response=$(curl -k -X POST -H "Content-Type: application/json" -H 'Authorization: Bearer '$token -d "$payload" "$url")

                echo "$response"
             done < output.csv
    else
        echo "Failed to get the access token, Please check with administrator."
        exit 1
    fi
else
    echo "Failed to get token, Please check with administrator."
fi

# Clean up temporary response file
rm response.json