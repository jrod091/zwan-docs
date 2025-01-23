#!/bin/bash

source ./.env

echo "DIRECTOR_IP: $DIRECTOR_IP"
echo "VPN_REALM_NAME: $VPN_REALM_NAME"

if [[ -z "$DIRECTOR_IP" ]]; then
    echo "ERROR!! Provide Director IP."
    exit 1;
fi

if [[ -z "$VPN_REALM_NAME" ]]; then
    echo "ERROR!! Provide VPN_REALM_NAME."
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

MASTER_URL='https://'$DIRECTOR_IP':8082/auth/realms/master/protocol/openid-connect/token'
CREATE_USER_URL='https://'$DIRECTOR_IP':8082/auth/admin/realms/'$VPN_REALM_NAME'/users'

echo $MASTER_URL;

# Convert Excel file to CSV
xlsx2csv users.xlsx > output.csv

# Process CSV file 
while IFS=, read -r col1 col2 col3 col4
do
    # Make the curl request to obtain the access token
    gettoken=$(curl -k --location "$MASTER_URL" \
    --header 'Content-Type: application/x-www-form-urlencoded' \
    --data-urlencode 'grant_type=client_credentials' \
    --data-urlencode 'client_id=admin-cli' \
    --data-urlencode 'client_secret=secret')

    # Extract the access token from the response
    TOKEN=$(echo $gettoken | jq -r '.access_token')
    echo "Access Token: $TOKEN"

    FIRSTNAME=$col1
    LASTNAME=$col2
    EMAIL=$col3
    USERNAME=$FIRSTNAME$LASTNAME
    PASSWORD=$col4
    echo "username: " $USERNAME
    echo "firstName: " $FIRSTNAME
    echo "lastName: " $LASTNAME
    echo "email: " $EMAIL
    echo "password: " $PASSWORD 

    # Send request and capture response headers
    response=$(curl -k --location --write-out "%{http_code}\n%{response_code}" --silent "$CREATE_USER_URL" \
        --header 'Content-Type: application/json' \
        --header "Authorization: Bearer $TOKEN" \
        --data-raw '{
            "username": "'"$USERNAME"'",
            "enabled": true,
            "emailVerified": false,
            "firstName": "'"$FIRSTNAME"'",
            "lastName": "'"$LASTNAME"'",
            "email": "'"$EMAIL"'",
            "credentials": [
                {"type":"password","value":"'"$PASSWORD"'","temporary":false}
            ]	
        }')
    
    echo "Resonse: " $response
    http_code=$(echo "$response" | tail -n1)
    if [ "$http_code" -eq 404 ]; then
        echo " Realm not found. "
        exit 1;
    elif [ "$http_code" -eq 201 ]; then
        echo "$EMAIL User has created successfully."
    elif [ "$http_code" -eq 409 ]; then
        echo "$EMAIL User exists with same username."
    else
        echo "Unexpected HTTP Status Code: $http_code"
        exit 1;
    fi

done < output.csv
