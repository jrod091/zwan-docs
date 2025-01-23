

Steps to debug this kind of DNS issues if anyone else encounter in future.


1)	Check DNS unbound service is running. Systemctl status unbound 

Expected Scenario: It shud run without any failures

2)	Make sure the IP of the LAN interface is listed proper in the /etc/unbound/zwan/server/interfaces.conf.

Expected Scenario:  In this setup it should 172.7.0.3

3)	Make sure ACL in DNS server config page should list the LAN PC subnet

Expected Scenario:  In this setup it should 172.7.0.0/24

4)	Login to LAN PC and check the DNS server detail using the ‘resolvectl status’ command. 

Expected Scenario: In this setup it should display (172.7.0.1 & 172.7.0.3)

5)	From LAN PC, Perform Dig @<DNS server ip> <Domain name> eg: dig @172.7.0.3 amazon.com
If its fails check the error reported by dig, If it mentions server unreachable. Perform step 6
               
Expected Scenario: Dig should return success with ips of amazon fqdn

6)	From edge controller, Perform Dig @<DNS server ip> <Domain name> eg: dig @172.7.0.3 amazon.com

Expected Scenario: Dig should return success with ips of amazon fqdn

7)	If step 5 fails and step 6 works, then iDNS server is configured properly, but requests are not honored or not reaching DNS server.

8)	To verify Step 7, perform Step 5 , but add tcpdump -i <LAN interface> port 53 . If you do so not see the DNS request from LAN PC IP address, then firewall in CPE is blocking the DNS request.

9)	To verify firewall is proper, check iptables -t filter -L SYS_DNS -n -v

Expected result: All the desired LAN subnets should be displayed. In this setup 172.7.0.0/24 was missing.

Further debugging,  we narrowed it down to the script which adds the subnet to SYS_DNS chain was the issue
