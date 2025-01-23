# zWAN IPv6 setup. 

zWAN director support IPv6 starting version 1.3.3 with the below restrictions.  

 - FQDN name is required to access director with IPv6. 
 - Only public facing IP will be IPv6, and director server should have local IPv4 IP address. 
 - Director UI is accessible using IPv4 address or FQDN name, Cannot access director using IPv6 IP address.
 - FQDN will point IPv6 IP on public facing and FQDN will point to IPv4 on local network. The DNS should be set accordingly. 
 - For testing where DNS configuration of FQDN is not possible below manual changes are required. 
	- Change /etc/hosts in client system and set domain name to IPv6 IP address. 
	- Change /etc/hosts in K3S and set domain name to IPv4 IP address. 


