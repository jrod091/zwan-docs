Please make sure CPE has valid PRODUCT_ID. CPE connects to Provisioning Server with PRODUCT_ID and get Director Information (_mgmt_url and _access_key).

Check the service "systemctl status amz_mgmttunnel"

1) Make sure Internet is available. from Local webUI or secure shell, perform ping test to a public IP (say, 8.8.8.8), Provisioning Server and Director. If director is hosted with fQDN, ping using FQDN and make sure the FQDN is resolved to a valid IP address. If it does not resolve, refer DNS troubleshooting.

2) IF the Internet is available and Director is reachable, check if the MGMT_URL and ACCESS KEY are correct. Crosscheck this information with Director.

3) If the MGMT URL or KEY is not correct, fix it in Provisioing Server. (Can change it via LocalUI or Secure Shell, but it not recommeneded for End User)

4) Next check if the MGMTtunnel port 1194 is Open both at CPE side and Director Side. 
    If CPE uses LTE,5G, typically this port is open by default.
    If CPE is behind a Router, then check the Routers firewall and make sure the port is open
    If the CPE is hosted in Cloud, then check the Cloud Inbound and Outbound firewall rules that the port is open
    If the CPE is hosted in DC as a VM, then check the host system that the no firewall rules block the mgmt tunnel port.
    

5) Next check the Director that the OpenVPN port 1194 is open

6) Make sure there is atleast one WAN interface is the system and gateway for that WAN interface is set. 
    
Finally check the logs var/log/mgmttunnel.log for any other issues. 