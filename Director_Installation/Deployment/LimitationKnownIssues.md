# zWAN Director Cluster Limitations and Known Issues. 

### Content
 - [Limitations](#limitations) 
 - [Known Issue](#known-issues) 

**Known Issues**

- DC concentrator switch over 
  - The DC concenterator IP is updated to branches on the below cases 
    1. When tunnel connected event is received from branch and active DC is available during that time.
    2. When DC concenterator is set to active and Brnaches Mgmttunnel state up is set in the database
    During switchover between the DC and DR sites, there may be a chance of both the above said conitions not met
    because of the tunnel connected events for Branches are received before the Concenterator's tunnel connected event or
    When Concenterator is set as Active, branch state is not up in database.
 
    During these times, the user can use the "Update Branche to Active Node" button in Concenterator page.

- On deployment update there might be duplicate tunnel server entry in tenant's page.
- ELK Configuration Backup & Restore doesn't have FTP support.
- ELK Data Backup & Restore supports only Minio.

**Limitations**

- Feature: 
  - Automatic group creation based on region and model number
    - Group will be created only for new onboarding.
    - To create a group based on model number metadata needs to be updated (A fresh import of metadata or edit the existing metadata and save it).
  - When upgrade is called for the deployment, the UI pages may not work as expected till the upgrade gets over.
    - This is expected because as the services are being changed in the setup.