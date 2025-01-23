# Google Configuration guide

\*\* Configure Google Authentication

- From zWAN UI, Settings --> ZID Login
Login to zID with tenant credentials

![zID](images/google/zidlink.png)


![zID](images/google/zidlogin1.png)


\*\* Configuring google as identity provider

Add Identity Provider as Google
1. Select the Identity providers under Configure section
![](images/google/googleidentity.png)

2. Select Google under social

3. Copy the Redirect URI and note it.
![](images/google/copyuri.png)

## Create a Project in Google

1. Launch the URL https://console.cloud.google.com/getting-started in browser

![](images/google/googlelaunch.png)

2. Login to gmail account
3. Click Select Project

![](images/google/selectproject.png)

4. Click New Project

![](images/google/selectproject1.png)


![](images/google/newproject.png)

5. Give the Project Name and click Create

![](images/google/projectdash.png)

6. In getting started menu, click Explore and enable API’s

![](images/google/enableapi.png)

![](images/google/enableapi1.png)

7. Go to credentials, click Create Credentials and click consent screen

![](images/google/credentials1.png)

![](images/google/consentscreen.png)

8. Select External and click create

![](images/google/oauth1.png)

9. In app registration page, give the mail address and click save and continue

![](images/google/editapp.png)

10. Click save and continue for the remaining options.

![](images/google/editapp1.png)

![](images/google/editapp2.png)

11. Click Back to Dashboard
12. Again go to credentials and click O Auth Client ID

![](images/google/oauthclient.png)

13. Select Web Application


![](images/google/createoauth.png)

![](images/google/createoauth1.png)

14. Provide application name, authorized redirect URI which one copied from ZID identity provider page. 
Example:
https://zwanqa.amzetta.co.in:8082/auth/realms/zwan-tenant/broker/google/endpoint


![](images/google/URI.png)


![](images/google/createdclient.png)


15. OAuth client will create with client ID and secret code.

![](images/google/copyuri1.png)

![](images/google/copyuri2.png)

16. Copy the client ID and secret code

## Add Identity Provider as Google Continued…

4. Go to ZID Page, give the client ID, secret code, left as default for remaining options and save it

![](images/google/addidentity.png)

![](images/google/addidentity1.png)

![](images/google/addidentity2.png)

5. Now login to Director UI, google authentication option will be shown in UI

![](images/google/googlelogin.png)

6. Give the valid user credentials and login.


![](images/google/login1.png)

7. UI shown as "you do not have access to the requested Resource"

![](images/google/access.png)

8. Login to Director UI with the default user credentials, and go to users page.

9. Select the gmail user which one dont have access and give access.

![](images/google/userpermission.png)

![](images/google/grantpermission.png)

10. Now Refresh the UI which shown the permission issue or login again.

11. The Director UI will be launched, can see the login accoutn details under myaccount.

![](images/google/afterlogin.png)


**Note:**

Google Login will work with external fqdn which is a public one.

## References

https://keycloakthemes.com/blog/how-to-setup-sign-in-with-google-using-keycloak





