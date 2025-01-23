# Curator

- To maintain the physical size of disk of ELK server database should be cleaned for certain period of time.

- Curator is the tool to set up the retention policy for ELK.

- ELK used to remove the older indices to manage the storage of elasticSearch. The default retention period of ELK is categorized on the index pattern.

### Curator API to Delete all tenant specific indices

- Post call requires the ELKVM IP and the port and the retention count (Retention count is represented in weeks) and the 5 field cron value in UTC representation.

      curl -X 'POST' '://<ELK_VM_IP:PORT>/v1.0/SetRetentionScheduleMsp' -H 'accept: application/json' -H 'Content-Type: application/json' -d '{"elastiflowretentioncount":<RETENTIONCOUNT>, "suricataretentioncount": <RETENTIONCOUNT>, "retentioncron": "<5 field CRON based on UTC>"}'

example:

     curl -X 'POST' 'http://192.168.9.249:3000/v1.0/SetRetentionScheduleMsp' -H 'accept: application/json' -H 'Content-Type: application/json' -d '{"elastiflowretentioncount":24, "suricataretentioncount": 24, "retentioncron": "10 12 9 10 *"}'

Success response:

     {"name":"SUCCESS","errorCode":0,"msg":"Retention configured successfully"}
Failure response:
     
     {"name":"Error","errorCode":1003,"msg":"ENOENT: no such file or directory, open '/autodelete/autodelete_indices_template.yml'"}

- Once the cron run, it deleted the indices of respective tenant.
- Command to check the indices:

      curl -XGET -k -u admin:zWAN@teamw0rk https://localhost:9200/_cat/indices


### Curator API to delete Tenant Specific

- Post call requires the ELKVM IP , port , tenant name and retention count (Retention count is represented in weeks) and the 5 field cron value in UTC representation.

       curl -X 'POST' 'http://<ELK_VM_IP:PORT>/v1.0/SetRetentionSchedule' -H 'accept: application/json' -H 'Content-Type: application/json' -d '{"tenantname": "<TENANTNAME>", "elastiflowretentioncount":<RETENTIONCOUNT>, "suricataretentioncount":<RETENTIONCOUNT>, "retentioncron": "<5 field CRON based on UTC>"}'

example:
      
       curl -X 'POST' 'http://192.168.9.249:3000/v1.0/SetRetentionSchedule' -H 'accept: application/json' -H 'Content-Type: application/json' -d '{"tenantname": "demo-tenant", "elastiflowretentioncount":24, "suricataretentioncount":24, "retentioncron": "10 12 9 10 *"}'

Success response:

       {"name":"SUCCESS","errorCode":0,"msg":"Retention configured successfully"}

Failure response:

       {"name":"Error","errorCode":1003,"msg":"ENOENT: no such file or directory, open '/autodelete/autodelete_indices_template.yml'"}

- Once the cron run, it deleted the indices of respective tenant.
- Command to check the indices:

      curl -XGET -k -u admin:zWAN@teamw0rk https://localhost:9200/_cat/indices


### Delete curator API

- Deletes the curator that has been scheduled it requires tenant name to delete the respective tenant specific file .

      curl -X DELETE http://<ELK_VM_IP:PORT>/v1.0/DeleteRetentionSchedule -H 'accept: application/json' -H 'Content-Type: application/json' -d '{"tenantname": "<TENANTNAME>"}'

Example:

      curl -X DELETE http://192.168.9.249:3000/v1.0/DeleteRetentionSchedule -H 'accept: application/json' -H 'Content-Type: application/json' -d '{"tenantname": "demo-tenant"}'

Success response:

        {"name":"SUCCESS","errorCode":0,"msg":"Retention configuration deleted successfully"}


### Reference and Notes
       
       NOTE:

       ELK VM IP for standalone setup     - 192.168.9.249
       Port                               - 3000
       Retention count is represented in numbers
       Cron (5 field cron – UTC representation)

Reference:
 
 - 5 field cron reference and debugging 

       https://crontab.guru/

     


    
