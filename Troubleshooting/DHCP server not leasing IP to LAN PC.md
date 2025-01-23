Troubleshooting/ DHCP server not leasing IP to LAN PC.md 

1) Check LAN PC connectivity to DHCP server. 
    - Verify the cabling to the LAN PC, CPE and switch.
    - Check the NIC status on client and server.
2) Verify the DHCP server config.
    - Verify the subnet is configured on the correct interface.
    - Check the default/max lease times, router and gateway config details.
    - Check any static IP is already assigned for the client mac address.
    - Check the leases page info and verify whether other LAN PC's are assigned DHCP IP's. This will help to narrow down whether its a specific client PC issue.
    - Check whether the DHCP range is maxed out with existing leased out clients.
3) Verify DHCP server process is running in the CPE.
    - Login to the CPE console and execute ps ax | grep dhcpd to verify the DHCP server process status.
        ```
        bash-5.1# ps ax | grep dhcpd
            187346 ?        Ssl    0:32 dhcpd -cf /var/register/system/dhcp/dhcpd.conf -lf /var/register/system/dhcp/dhcpd.leases -q
        ```
4) Verify dhcp requests are received  on the CPE side using tcpdump.
    tcpdump -i <Interface name> port bootps. Successfull tcpdump capture for a dhcp request and replay is as follows
    ```
       bash-5.1# tcpdump -i ETH01 port bootps -nvvv
        tcpdump: listening on ETH01, link-type EN10MB (Ethernet), snapshot length 262144 bytes
        09:51:04.076908 IP (tos 0x10, ttl 128, id 0, offset 0, flags [none], proto UDP (17), length 328)
            0.0.0.0.68 > 255.255.255.255.67: [udp sum ok] BOOTP/DHCP, Request from 02:00:ac:01:05:01, length 300, xid 0xcabf3f41, Flags [none] (0x0000)
                Client-Ethernet-Address 02:00:ac:01:05:01
                Vendor-rfc1048 Extensions
                    Magic Cookie 0x63825363
                    DHCP-Message (53), length 1: Discover
                    Requested-IP (50), length 4: 172.5.0.101
                    Hostname (12), length 7: "CPE5_L1"
                    Parameter-Request (55), length 13:
                    Subnet-Mask (1), BR (28), Time-Zone (2), Default-Gateway (3)
                    Domain-Name (15), Domain-Name-Server (6), Unknown (119), Hostname (12)
                    Netbios-Name-Server (44), Netbios-Scope (47), MTU (26), Classless-Static-Route (121)
                    NTP (42)
                    Client-ID (61), length 19: hardware-type 255, ac:01:05:01:00:01:00:01:2d:de:11:2c:02:00:ac:01:05:01
                    END (255), length 0
                    PAD (0), length 0, occurs 5
        09:51:05.141651 IP (tos 0x10, ttl 128, id 0, offset 0, flags [none], proto UDP (17), length 328)
            172.5.0.1.67 > 172.5.0.101.68: [udp sum ok] BOOTP/DHCP, Reply, length 300, xid 0xcabf3f41, Flags [none] (0x0000)
                Your-IP 172.5.0.101
                Server-IP 172.5.0.1
                Client-Ethernet-Address 02:00:ac:01:05:01
                Vendor-rfc1048 Extensions
                    Magic Cookie 0x63825363
                    DHCP-Message (53), length 1: Offer
                    Server-ID (54), length 4: 172.5.0.1
                    Lease-Time (51), length 4: 31536000
                    Subnet-Mask (1), length 4: 255.255.255.0
                    Default-Gateway (3), length 4: 172.5.0.1
                    Domain-Name-Server (6), length 4: 172.5.0.1
                    END (255), length 0
                    PAD (0), length 0, occurs 26
        09:51:05.143519 IP (tos 0x10, ttl 128, id 0, offset 0, flags [none], proto UDP (17), length 329)
            0.0.0.0.68 > 255.255.255.255.67: [udp sum ok] BOOTP/DHCP, Request from 02:00:ac:01:05:01, length 301, xid 0xcabf3f41, Flags [none] (0x0000)
                Client-Ethernet-Address 02:00:ac:01:05:01
                Vendor-rfc1048 Extensions
                    Magic Cookie 0x63825363
                    DHCP-Message (53), length 1: Request
                    Server-ID (54), length 4: 172.5.0.1
                    Requested-IP (50), length 4: 172.5.0.101
                    Hostname (12), length 7: "CPE5_L1"
                    Parameter-Request (55), length 13:
                    Subnet-Mask (1), BR (28), Time-Zone (2), Default-Gateway (3)
                    Domain-Name (15), Domain-Name-Server (6), Unknown (119), Hostname (12)
                    Netbios-Name-Server (44), Netbios-Scope (47), MTU (26), Classless-Static-Route (121)
                    NTP (42)
                    Client-ID (61), length 19: hardware-type 255, ac:01:05:01:00:01:00:01:2d:de:11:2c:02:00:ac:01:05:01
                    END (255), length 0
        09:51:05.146570 IP (tos 0x10, ttl 128, id 0, offset 0, flags [none], proto UDP (17), length 328)
            172.5.0.1.67 > 172.5.0.101.68: [udp sum ok] BOOTP/DHCP, Reply, length 300, xid 0xcabf3f41, Flags [none] (0x0000)
                Your-IP 172.5.0.101
                Server-IP 172.5.0.1
                Client-Ethernet-Address 02:00:ac:01:05:01
                Vendor-rfc1048 Extensions
                    Magic Cookie 0x63825363
                    DHCP-Message (53), length 1: ACK
                    Server-ID (54), length 4: 172.5.0.1
                    Lease-Time (51), length 4: 31536000
                    Subnet-Mask (1), length 4: 255.255.255.0
                    Default-Gateway (3), length 4: 172.5.0.1
                    Domain-Name-Server (6), length 4: 172.5.0.1
                    END (255), length 0
                    PAD (0), length 0, occurs 26
    ```
5) Verify and debug the client/LAN CPE side DHCP requests. 

    - If LAN PC Is a linux system 
        ```
        ps ax | grep dhclient
        ```

    - Trying killing the dhclient process and rerun the dhclient in verbose mode to check for more information in client side.

        ```
            dhclient -i <interface name> -v
        ```
        Successfull dhcp request message in foreground mode will be as follows.

        ```
            root@CPE5_L1:/home/router# dhclient -i eth1 -v
            Internet Systems Consortium DHCP Client 4.3.5
            Copyright 2004-2016 Internet Systems Consortium.
            All rights reserved.
            For info, please visit https://www.isc.org/software/dhcp/

            Listening on LPF/eth1/02:00:ac:01:05:01
            Sending on   LPF/eth1/02:00:ac:01:05:01
            Sending on   Socket/fallback
            DHCPDISCOVER on eth1 to 255.255.255.255 port 67 interval 3 (xid=0xcabf3f41)
            DHCPREQUEST of 172.5.0.101 on eth1 to 255.255.255.255 port 67 (xid=0x413fbfca)
            DHCPOFFER of 172.5.0.101 from 172.5.0.1
            DHCPACK of 172.5.0.101 from 172.5.0.1
            bound to 172.5.0.101 -- renewal in 13134162 seconds.

        ```