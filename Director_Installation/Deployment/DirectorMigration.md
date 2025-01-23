# Director And Analytics Configuration Backup and Restore**
Director update from one version to another version is automatically updated from the deployment scripts, however there are some special cases where automatic update is not possible and a manual steps are required. 
Below are the procedure to be followed for from and to versions. 

 - [1.2.2 to 1.3.2](#12x-to-132)

## 1.2.x to 1.3.2

**Director Backup from 1.2.2-build-5**

**Configure SFTP Server**

1. Login to MSP page with the URL https://xxxxx:7080 with admin@zwan-msp.com
zWAN@teamw0rk
2. Go to DB Backup page.
3. Click add SFTP server
4. Give the valid host, port number, path, username, password and add it.

**Add Backup**

1. Click Add Backup JOB, select the schedule for hourly or give the specific time in custom cron and add it
2. Click the start icon to start it
3. Click the logs to verify the backup status
4. Once backup done check the backup files in SFTP location.

**Note:** Make sure Backup files copied into SFTP location before cleanup. And also take one copy to some other locations

**ELK Data Backup**

Refer this link https://gitlab.amzetta.com/sdwan/zwan-doc/-/blob/master/Director_Installation/Deployment/ElkDataBackupAndRestore/ELK_data_backup_restore.md

**Cleanup the Deployment**

Go to Controller host and cleanup the deployment by executing the command
./setup.sh standalone cleanup

**Deploy Build 1.3.2-build-3**
1. Go to Controller host.
2. Pull the Source code from git by using this command 
git clone https://172.16.120.65/sdwan/deployment.git -b 1.3.2-build-3 
3. Modify the master.yml file 
4. Execute the command ./setup.sh standalone to deploy Director

**Configure S3 Minio**
1. Login to minio console page with the URL https://xxxxx:7080/minio with admin@zwan-msp.com zWAN@teamw0rk
2. Go to buckets and create bucket
3. Click the bucket ,change the access policy to public and set it
4. Go to access keys, click create access key, give the access key and secret key and create it
5. Download and import the keys once created for future reference
6. Login to zWAN MSP page with the URL https://xxxxx:7080/ with admin@zwan-msp.com zWAN@teamw0rk
7. Go to DB Backup --> Server Configuration--> Select server S3
8. Give the access key, secert key, bucket name ( Which is provided in minio console) , URL https://xxxx:7081 and add it.

**Note:**
If public IP is configured means 7081 port needs to be opened then only it will work

**Restore the Deployment**
1. Copy the Director Backup files from SFTP to S3 Bucket by manually using upload option
2. Go to Controller host and restore by executing the command
./setup.sh standalone restore
3. Prompt will ask Restore type, Access key, secret key and URL
Restore Type - S3, Access key, secret key ( Which is provided in minio console) , URL https://xxxx:7081 
4. Login to zWAN MSP page with the URL https://xxxxx:7080/ with admin@zwan-msp.com zWAN@teamw0rk once restore gets completed.
5. Go to DBBackup--> Server Configuration-->Delete the SFTP Server details
6. Select server S3 ,give the access key, secert key, bucket name ( Which is provided in minio console) , URL https://xxxx:7081 and add it.
7. Configure DBBackup, Analytics Backup and start it for perodic backups

**ELK Data Restore**

Refer this link https://gitlab.amzetta.com/sdwan/zwan-doc/-/blob/master/Director_Installation/Deployment/ElkDataBackupAndRestore/ELK_data_backup_restore.md

**Note:**
1. Firmware which is uploaded into minio will not be backed up and restored
administrator need to take backup manually and need to upload to new one.
2. For ELK Storage alert, ELK service needs to updated from controller host machine
./setup standalone update elk






