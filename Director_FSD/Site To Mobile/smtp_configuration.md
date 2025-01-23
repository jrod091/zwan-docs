# SMTP configuration guide
 - Download the files from [Scripts](https://gitlab.amzetta.com/sdwan/zwan-doc/-/tree/zid-smtp-bulk-user/Director_FSD%2Fsite-to-mobile%2Fscripts) (Skip this step if already downloaded).
 - Update director IP and SMTP details in .env file
 
        ``` 
            DIRECTOR_IP=<director_ip>
            VPN_REALM_NAME=vpn
            SMTP_HOST=smtp.office365.com
            SMTP_PORT=587
            SMTP_FROM_EMAIL_ID=testuser@domain.com // Sender Email Address
            SMTP_USER=admin@domain.com //Sender Email credentails
            SMTP_PASSWORD=password
        ```
  - Run config-smtp.sh on the director host machine, This script will configure the SMTP in vpn realm.