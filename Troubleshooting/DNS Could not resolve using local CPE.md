1) Check WAN connectivity of Branch.
    - Check the link status
    - Ping 8.8.8.8 or any public IP
    - Check firewall rules on WAN interfaces
    - Ping the forwarding servers reachability from the LAN PC and CPE
2) Check DNS configuration parameters in branch CPE.
    * Verify the accuracy of DNS configuration paramters 
        - Interfaces and its IP
        - Make sure ACLs are configured for appropriate subnets.
        - Forward Zones. IP and Hostname of the forwarding servers.
        - TLS enabled server name of Upstream server for forward Zone. Enable/Disable TLS Upstream to narrow down the issue.
        - Enable/Disable DNSSEC to verify whether DNSSEC is causing issues.
        
3) Make sure the DNS IP's (CPE- LAN Interface IP /gateway IP on which DHCP server is configured) is updated correctly in DHCP server config section.

4) Check DNS is resolving in Branch by executing dig command.  Check the result status for NXDOMAIN, REFUSED or SERVFAIL errors in LAN PC and CPE.
    eg: dig @<LAN interface IP> <any fqdn name such as amazon.com/google.com>
        dig @172.1.0.1 amazon.com
        Successful query will return a similar output. Here IP 192.168.75.130 is the local LAN IP through which DNS queries are resolved. 
        root@Kettop-5:/home/router# dig @192.168.75.130 amazon.com
        ```
            ; <<>> DiG 9.18.18-0ubuntu0.22.04.2-Ubuntu <<>> @192.168.75.130 amazon.com
            ; (1 server found)
            ;; global options: +cmd
            ;; Got answer:
            ;; ->>HEADER<<- opcode: QUERY, status: NOERROR, id: 9976
            ;; flags: qr rd ra; QUERY: 1, ANSWER: 3, AUTHORITY: 0, ADDITIONAL: 1

            ;; OPT PSEUDOSECTION:
            ; EDNS: version: 0, flags:; udp: 1232
            ;; QUESTION SECTION:
            ;amazon.com.                    IN      A

            ;; ANSWER SECTION:
            amazon.com.             894     IN      A       205.251.242.103
            amazon.com.             894     IN      A       54.239.28.85
            amazon.com.             894     IN      A       52.94.236.248

            ;; Query time: 83 msec
            ;; SERVER: 192.168.75.130#53(192.168.75.130) (UDP)
            ;; WHEN: Thu Apr 18 15:12:42 EDT 2024
            ;; MSG SIZE  rcvd: 87
        ```
    
5) Increase the verbose logging level of the DNS server in branch to check for any errors while trying to resolve the queries. 
    - Logging can be changed in DNS advanced settings (Wheel icon) in DNS server config page. 
    - Perform the above dig commands to check for errors. 
    - Check for "REFUSED" errors, TLS handshake errors

6) Check the output of Unbound service.
    - Executing `systemctl status unbound`. 
    - If the service is not running this may result in DNS query failures.

7) Check for any firewall rules blocking any traffic related to the DNS queries. 
    - Check DNS specific ports such as 53/853 
    - Any fqdns are blocked related to the internet traffic.  

8) Check LAN PC's default DNS/ Primary DNS server is the CPE LAN IP. 
    - Check the LAN PC's browser DNS config whether DoH is enabled and a pass thru DNS server  IP is configured.(eg: cloudflare IP). 
    - Firefox has this a default config. This is to make sure all DNS queries from LAN PCs are directed through CPE DNS server IP.
        
9) Check DNS filter is enabled and whether DNS filter is blocking any of the intended internet traffic
    - Check for conflicting fqdn names in custom allow/block filter list.
    - Check the memory and CPU usage of DNS application after applying or enabling DNS filter.
    - Check in DNS alerts page in ELK for any blocked fqdns when any query is failing.
                
10) Check for any DNS related logs in syslog, dns.log and tegernsee log files

11) Check system memory, storage and CPU usage in syslog for OOM or CPU lockup or filesystem full scenarios.
    
12) For HA, please refer the recommended config for HA-DNS section in zWAN docs
    
