#!/bin/bash

source ./.env

if [[ -z "$DIRECTOR_IP" ]]; then
    echo "ERROR!! Provide Director IP."
    exit 1;
fi

if [[ -z "$TENANT_REALM_NAME" ]]; then
    echo "ERROR!! Provide tenant realmname."
    exit 1;
fi

if [[ -z "$TENANT_LOGIN_USER" ]]; then
    echo "ERROR!! Provide tenant login user."
    exit 1;
fi

if [[ -z "$TENANT_LOGIN_PASSWORD" ]]; then
    echo "ERROR!! Provide tenant login password."
    exit 1;
fi

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

# Convert Excel file to CSV
xlsx2csv users.xlsx > output.csv

# Get JWt token
get_token(){
    TOKEN_URL='https://'$DIRECTOR_IP':8082/auth/realms/'$TENANT_REALM_NAME'/protocol/openid-connect/token'

    getloginToken=$(curl -k --location "$TOKEN_URL" \
        --header 'Content-Type: application/x-www-form-urlencoded' \
        --data-urlencode 'grant_type=password' \
        --data-urlencode 'client_id='$TENANT_REALM_NAME-client'' \
        --data-urlencode 'client_secret=secret' \
        --data-urlencode 'username='$TENANT_LOGIN_USER'' \
        --data-urlencode 'password='$TENANT_LOGIN_PASSWORD'' \
        -w "%{http_code}" -o response.json)
    
    http_code=$(echo "$getloginToken" | tail -c 4)

    if [ "$http_code" -eq 200 ]; then
        login_token=$(jq -r '.access_token' response.json)

        getAccessToken=$(curl -k --location "$TOKEN_URL" \
        --header "Authorization: Bearer $login_token" \
        --header 'Content-Type: application/x-www-form-urlencoded' \
        --data-urlencode 'grant_type=urn:ietf:params:oauth:grant-type:uma-ticket' \
        --data-urlencode 'audience='$TENANT_REALM_NAME-client'' \
        --data-urlencode 'permission=certificate-service' \
        -w "%{http_code}" -o response.json)

        http_code=$(echo "$getAccessToken" | tail -c 4)

        if [ "$http_code" -eq 200 ]; then
            accessToken=$(jq -r '.access_token' response.json)
            echo "$accessToken"
        else
            echo "Error: HTTP response code:  $http_code"
            echo "Failed to get access token, Please check with administrator."
            cat response.json
            exit 1;
        fi
        
    else
        echo "Error: HTTP response code:  $http_code"
        echo "Failed to get Token, Please check with administrator."
        cat response.json
        exit 1;
    fi
}


#Get list of mobile clients
get_mobile_clients() {
    local token="$1"
    query='{"operationName":"getFilteredMobileClients","variables":{},"query":"query getFilteredMobileClients($page: Page, $sort: Sort, $searchFilter: SearchFilter) {\n  getFilteredMobileClients(page: $page, sort: $sort, searchFilter: $searchFilter) {\n    offset\n    limit\n    totalCount\n    result {\n      id\n      clientName\n      __typename\n    }\n    __typename\n  }\n}\n"}'

    url="https://$DIRECTOR_IP/$TENANT_REALM_NAME/api/certificate-service/graphql"

    response=$(curl -k -X POST \
    -H "Content-Type: application/json" \
    -H "Authorization: Bearer "$token \
    -d "$query" \
    $url \
    -w "%{http_code}" -o response.json)
    echo "=====>" $response
    http_code=$(echo "$response" | tail -c 4)

    if [ "$http_code" -eq 200 ]; then
          for row in $(echo "${response}" | (jq -r '.data.getFilteredMobileClients.result[] | @base64' response.json)); do
                _jq() {
                    echo "${row}" | base64 --decode | jq -r "${1}"
                }

                id=$(_jq '.id')
                clientName=$(_jq '.clientName')
                #echo "Id:" $id
                #echo "clientName:" $clientName
                # Define the path to the CSV file
                csv_file="./output.csv"

                # Read each line of the CSV file
                while IFS=',' read -r col1 col2 rest_of_line; do
                    # Merge the first two columns
                    merged_data="$col1$col2"
                    
                    # Compare merged data with your data
                    if [ "$merged_data" = "$clientName" ]; then
                        echo "Match found: $merged_data"
                        # Download client ovpn configuration file.
                        download_ovpn "$id" "$clientName" "$token"
                    fi
                done < "$csv_file"

               
        done
    else
        echo "Error: HTTP response code:  $http_code"
        echo "Failed to get mobile client list, Please check with administrator."
        cat response.json
        exit 1;
    fi
    
}

# Download ovpn configuration file
download_ovpn(){
     local id="$1"
     local clientName="$2"
     local token="$3"
    
    query='{"operationName":"downloadMobileClientManifest","variables":{"id":"'$id'"},"query":"query downloadMobileClientManifest($id: String!) {\n  downloadMobileClientManifest(id: $id)\n}\n"}'

    response=$(curl -k -X POST -H 'Authorization: Bearer '$token -H "Content-Type: application/json" -H "" --data-binary "$query" https://$DIRECTOR_IP/$TENANT_REALM_NAME/api/certificate-service/graphql)
    echo "Download response: " $response
    data=$(echo "$response" | jq -r '.data.downloadMobileClientManifest')

    echo "$data" > $clientName.ovpn
}

# Get JWT Token
token=$(get_token)
echo "The result token is : $token"

#Get list of mobile client and download it.
get_mobile_clients "$token"

rm response.json

