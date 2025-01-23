# Configure Radius server role in zWAN

Login to zWAN UI

Go to Settings --> Click zID Login

![zidlink](zidlink.png)

Give login credentials based on the tenant

Example: If default tenant means user name : admin@zwan-tenant.com password : zWAN@teamw0rk

Go to Roles and click add role.

Give the role name as radius (name should be in radius (small letters)) and save it.

Click next tab attributes; add host, port and secret key and save it.

```
host    - <radius_server_ip>
port    – <radius_server_port>
secret  – <radius_server_secret>
```

Ex:

```
host    - *.*.*.*
port    – 1812
secret  – testing123
```

![radius_role_zid](images/radius_role_zid/radius_role_in_zid_1.png)

![radius_role_zid](images/radius_role_zid/radius_role_in_zid_2.png)

![radius_role_zid](images/radius_role_zid/radius_role_in_zid_3.png)

Go to authentication page, click copy and save it as Radius Authentication (user-preferred name)

![radius_role_zid](images/radius_role_zid/radius_role_in_zid_4.png)

Select Radius Authentication from flows.

![radius_role_zid](images/radius_role_zid/radius_role_in_zid_5.png)

Delete Username Password Form

![radius_role_zid](images/radius_role_zid/radius_role_in_zid_6.png)

Click add execution in Radius Authentication forms, select Radius Username Password form and save it.

![radius_role_zid](images/radius_role_zid/radius_role_in_zid_7.png)

![radius_role_zid](images/radius_role_zid/radius_role_in_zid_8.png)

![radius_role_zid](images/radius_role_zid/radius_role_in_zid_9.png)

Click the up arrow nearby Radius Username Password form to move up.

![radius_role_zid](images/radius_role_zid/radius_role_in_zid_10.png)

![radius_role_zid](images/radius_role_zid/radius_role_in_zid_11.png)

Go to bindings, select radius authentication and save it.

![radius_role_zid](images/radius_role_zid/radius_role_in_zid_12.png)

Launch director URL[https://<director_ip>:<director_port>/<tenant_name>],

Give the valid radius user credentials click login.

At first login, The user doesn't have any permission, It will show below error.

![radius_role_zid](images/radius_role_zid/permission-error.png)

Login to the director with superadmin credentials and go to user’s page.

![radius_role_zid](images/radius_role_zid/radius_role_in_zid_14.png)

Click on "Edit" icon, Assign role and Edge controller[Assign Or Unassign] and hit "UPDATE" button.

![radius_role_zid](images/radius_role_zid/radius_role_in_zid_15.png)

![radius_role_zid](images/radius_role_zid/radius_role_in_zid_16.png)

Now try to login to the director with the radius user.
