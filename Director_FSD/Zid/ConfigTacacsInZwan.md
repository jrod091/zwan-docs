# Configure Tacacs role in zWAN

Login to zWAN UI

Go to Settings --> Click zID Login 

![zidlink](zidlink.png)

Give login credentials based on the tenant

Example: If default tenant means user name : admin@zwan-tenant.com password : zWAN@teamw0rk

Go to Roles and click add role.

![tacacs_role_zid](images/tacacs_role_zid/tacacs_role_zid_1.png)

Give the role name as tacacs (name should be in tacacs (small letters)) and save it.

Click next tab attributes; add host, port and secret key and save it.

![tacacs_role_zid](images/tacacs_role_zid/tacacs_role_zid_2.png)

```
host    - <tacacs_server_ip>
port    – <tacacs_server_port>
secret  – <tacacs_server_secret>
```

Ex:

```
host    - *.*.*.*
port    – 49
secret  – testing123
```

![tacacs_role_zid](images/tacacs_role_zid/tacacs_role_zid_3.png)

Go to authentication page, click copy and save it as tacacs Authentication (user-preferred name)

![tacacs_role_zid](images/tacacs_role_zid/tacacs_role_zid_4.png)

Select tacas Authentication from flows

![tacacs_role_zid](images/tacacs_role_zid/tacacs_role_zid_5.png)

Delete Username Password Form

![tacacs_role_zid](images/tacacs_role_zid/tacacs_role_zid_6.png)

![tacacs_role_zid](images/tacacs_role_zid/tacacs_role_zid_7.png)

Click add execution in Tacas Authentication forms, select tacacs Username Password form and save it.

![tacacs_role_zid](images/tacacs_role_zid/tacacs_role_zid_8.png)

![tacacs_role_zid](images/tacacs_role_zid/tacacs_role_zid_9.png)

Click the up arrow nearby tacacs Username Password form to move up.

![tacacs_role_zid](images/tacacs_role_zid/tacacs_role_zid_10.png)

![tacacs_role_zid](images/tacacs_role_zid/tacacs_role_zid_11.png)

Go to bindings, select tacacs authentication and save it.

![tacacs_role_zid](images/tacacs_role_zid/tacacs_role_zid_12.png)

Launch director URL[https://<director_ip>:<director_port>/<tenant_name>],

Give the valid tacacs user credentials click login.

At first login, The user doesn't have any permission, It will show below error.

![tacacs_role_zid](images/tacacs_role_zid/permission-error.png)

Login to the director with superadmin credentials and go to user’s page.

![tacacs_role_zid](images/tacacs_role_zid/tacacs_role_zid_14.png)

Click on "Edit" icon, Assign role and Edge controller[Assign Or Unassign] and hit "UPDATE" button.

![tacacs_role_zid](images/tacacs_role_zid/tacacs_role_zid_15.png)

![tacacs_role_zid](images/tacacs_role_zid/tacacs_role_zid_16.png)

Now try to login to the director with the tacacs user.
