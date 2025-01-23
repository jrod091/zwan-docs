# Captive Portal
### Overview
 AmZ’s Captive portal / Guest Access (Wi-Fi & LAN) provides a simple high performance, secure internet access.

### Scope

The main purpose of captive portal is to block users from accessing the internet before they are validated and verified (authenticated) by the system, Users who are directly connected to the switch/port are authenticated via the captive portal before they can access the network.

### Physical Environment / HW Dependencies

    •Router with LAN Port and Wi-Fi 
    •ISP

### Configurations / SW Dependencies

    Supported OS: Linux / Ubuntu 
    Software Requirements: NodeJS, Nginx, OAuth, PassportJS & SQLite DB

### Security

    •REST communication with JWT Authentication
    •HTTPS for UI

### Compatibility

Web interface will be compatible with the following browsers:

    •IE 11.0 and later
    •Firefox 17.0 and later
    •Chrome 33.0 and later

# System Design
### Captive Portal

The interface (LAN/Wi-fi) is set in a captive-portal-enabled state so that all network traffic coming to it from the unauthenticated user (client) is dropped when the unauthenticated user tries to connect to the network, their HTTP/HTTPS traffic is redirected to an authentication page, using zID users are validated and the corresponding QoS setting is applied based on user profile.

### Overall Architecture
![CP_Overall_Arc](CPE_FSD/CaptivePortal/images/CP_Overall_Arc.png)

- Architecture consists of three parts.

    	a.UI
    	
        b.zID
        
        c.Backend
    
- Local UI part where captive portal is enabled here by selecting the respective interface
 ![CP_Enable_Disable](CPE_FSD/CaptivePortal/images/CP_Enable-Disable.jpg)

- ProviderUI part has HTTPS/HTTP traffic redirected to zID login page
 ![zID_Login](CPE_FSD/CaptivePortal/images/zID-Login.jpg)

- Backend will have the OAuth server which is running with passport.js node package and having data communications between CPE & UI 

- zID will manage user profile

### Use Case

 	- zwan_cp_interfaces: This IPSET contains the list of interfaces which has captive portal enabled 
 	- zwan_lancaptiveportal: This IPSET contains all authenticated LAN IP’s
 	- ZWAN_CPROLE_Power: This IPSET contains all LAN IP’s which is assigned with power user
 	- ZWAN_CPROLE_Normal: This IPSET contains all LAN IP’s which is assigned with Normal user
 	- ZWAN_CPROLE_Guest: This IPSET contains all LAN IP’s which is assigned with guest user

![IP_Set](CPE_FSD/CaptivePortal/images/IPSET.png)

### QoS Class Manager
New classes are created in QoS to assure the internet traffic with respect to their roles
![QoS_Class_Manager](CPE_FSD/CaptivePortal/images/QoS_Class_Manager.png)
### QoS Classifier
Traffic prioritization rules are configured here for the respective QoS classes
![QoS_Classifier](CPE_FSD/CaptivePortal/images/QoS_Classifier.png)
### Interface Manager
All the WAN Interfaces are applied with the captive portal related QoS classes
![Interface_Manager](CPE_FSD/CaptivePortal/images/Interface_Manager.png)
### Captive Portal Enable/ Disable
![CPE_Enable-Disable](CPE_FSD/CaptivePortal/images/CP_Enable-Disable.jpg)
### zID Authetication
![zID_Auth](CPE_FSD/CaptivePortal/images/zID-Login.jpg)
### Captive Portal Home Page
![CP_home](CPE_FSD/CaptivePortal/images/CP_Home.png)

### CP Interface List
### Authenticated LAN IP’s
### User Classifications