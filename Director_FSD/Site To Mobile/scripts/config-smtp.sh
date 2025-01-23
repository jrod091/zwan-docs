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

echo "DIRECTOR_IP: $DIRECTOR_IP"
echo "VPN_REALM_NAME: $VPN_REALM_NAME"
echo "SMTP_HOST: $SMTP_HOST"
echo "SMTP_PORT: $SMTP_PORT"
echo "SMTP_FROM_EMAIL_ID: $SMTP_FROM_EMAIL_ID"
echo "SMTP_USER: $SMTP_USER"
echo "SMTP_PASSWORD: $SMTP_PASSWORD"

if [[ -z "$DIRECTOR_IP" ]]; then
    echo "ERROR!! Provide Director IP."
    exit 1;
fi

if [[ -z "$VPN_REALM_NAME" ]]; then
    echo "ERROR!! Provide VPN_REALM_NAME."
    exit 1;
fi

if [[ -z "$SMTP_FROM_EMAIL_ID" ]]; then
    echo "ERROR!! Provide SMTP_FROM_EMAIL_ID."
    exit 1;
fi

if [[ -z "$SMTP_USER" ]]; then
    echo "ERROR!! Provide SMTP_USER."
    exit 1;
fi

if [[ -z "$SMTP_PASSWORD" ]]; then
    echo "ERROR!! Provide SMTP_PASSWORD."
    exit 1;
fi

MASTER_URL='https://'$DIRECTOR_IP':8082/auth/realms/master/protocol/openid-connect/token'

 response=$(curl -k --location "$MASTER_URL" \
        --header 'Content-Type: application/x-www-form-urlencoded' \
        --data-urlencode 'grant_type=client_credentials' \
        --data-urlencode 'client_id=admin-cli' \
        --data-urlencode 'client_secret=secret' \
        -w "%{http_code}" -o response.json)

    # Get the HTTP response code from the end of the response string
    http_code=$(echo "$response" | tail -c 4)

    if [ "$http_code" -eq 200 ]; then
        token=$(jq -r '.access_token' response.json)
        echo "$token"  

        echo "SMTP_FROM_EMAIL_ID: $SMTP_FROM_EMAIL_ID"
        echo "SMTP_PASSWORD: $SMTP_PASSWORD"

        response=$(curl -k --location --request PUT 'https://'$DIRECTOR_IP':8082/auth/admin/realms/'$VPN_REALM_NAME'' \
        --header 'Content-Type: application/json' \
        --header "Authorization: Bearer $token" \
        --data-raw '{
            "smtpServer": {
                "port": "'"$SMTP_PORT"'",
                "host": "'"$SMTP_HOST"'",
                "ssl": "false",
                "starttls": "true",
                "auth": "true",
                "from": "'"$SMTP_FROM_EMAIL_ID"'",
                "user": "'"$SMTP_USER"'",
                "password": "'"$SMTP_PASSWORD"'"
            },
            "resetPasswordAllowed":true
        }' -w "%{http_code}" -o response.json)
         echo "SMTP Response: " $response
         if [ "$response" -eq 204 ]; then
            echo "SMTP Configuration has been configured successfully."
         else
            echo "SMTP Configuration failed."
         fi
    else
        echo "Error: HTTP response code:  $http_code"
        echo "SMTP Configuration failed, Please check with administrator."
        cat response.json
    fi

# Clean up temporary response file
rm response.json