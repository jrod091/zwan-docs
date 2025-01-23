Trusted-MAC  Geofencing:

a. Make sure all the discovery failed LAN PC are connected via switch instead of direct cable connected to CPE. Directly cable connected LAN PC to CPE is not supported for trusted mac geo-fencing.
b. If we eliminate step 'a', perform nmap –sP <network subnet> and check the LAN PC is discovered in the result.
c. Make sure the LAN cables are connected and good. 
d. Make sure interface is UP.

Check syslog for logs with sub-string  'GEO' to check for geo-fencing logs to identify the failure.