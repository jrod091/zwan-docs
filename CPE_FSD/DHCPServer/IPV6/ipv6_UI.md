# Interfaces

## Overview: 

IPv6 is the newest version of the Internet Protocol, created to fix the limitations of IPv4. It comes with a big improvement: a 128-bit address space, allowing for a lot more unique addresses. By using hexadecimal notation and simpler headers, IPv6 makes addresses easier to handle and reduces the workload on routers and devices. The design of the protocol focuses on getting better at handling the increasing number of devices on the internet, making it really important for the internet to keep growing.

## Functionality:

In zWAN, interface is the main entry point and functional point in configuring most of its functionalities. Interfaces are named as ETH00, ETH01, ETH02 etc. 


![Interface](Images/interface.png)


Some of the functionalities provided for interfaces in zWAN are as follows

1) Adding a static IP
2) Edit/Modify a static IP
3) Remove the static IP
4) Create VLAN ( Virtual Lan interfaces) on interfaces
5) Assign static IP to the VLAN
6) Acquire DHCP IP from a DHCP server for the interface
7) Release the DHCP IP
8) Renew DHCP IP
9) Enable/Disable an Interface


![Interface](Images/add_ip.png)

A single interface can be assigned multiple static IP's depending on the need. To set a static IP on an interface, the network IP and its netmask should be provided. After configuring a static IP a unique ID will be assigned to the interface for that particular IP. This unique ID should be used to edit/delete the static IP.

![Interface](Images/dhcp_enable.png)

To acquire a DHCP IP on an interface, use Enable DHCP function and once DHCP IP is acquired, the user has the option to release the IP or renew the IP. User also has the option also to disable the DHCP if not needed.

VLAN functionalities will be explained under the VLAN section.

## Configuration Parameters

Network IP
Netmask 
UP/DOWN Interface
Twamp Responder: True/False, If this interface IP should part of twamp measurements and need to run as a responder for the corresponding IP

## Results

Status color codes are depicted as Green and Red.
GREEN: Indicates interface is active and UP
RED: Indicates interface is DOWN

## Use Cases:

User can assign IP, or acquire DHCP IP from a DHCP server and then connect to the required network device using the IP. Interface is the main entry point or exit for any incoming or outgoing data on the edge controller. VPN or IPSEC tunnels are created on top of the interfaces.


## Updates:
    
IPv6, a substantial upgrade over IPv4, introduces 128-bit addresses for an extensive pool, uses hexadecimal notation for simplified representation, and features streamlined headers for reduced processing. Notable advancements include stateless address autoconfiguration, integrated IPSec for enhanced security, and improved efficiency through the removal of the header checksum and multicast enhancements, solidifying IPv6's pivotal role in sustaining digital growth and overcoming IPv4 limitations.

## Known Limitations:

IPv6 doesn't use NAT as extensively as IPv4 due to its larger address space.
Broadcast is replaced by multicast and anycast in IPv6.

## Future Enhancements:

IPv6 supports more advanced QoS features, allowing for better traffic prioritization and a more efficient handling of network resources.

More information regarding the data usage, statistics, errors, failures can be displayed along with basic interface information.

Information regarding whether that a particular interface is part of bridge or bond should be displayed in UI. This particular information is available in the API using memberOf field in interface schema




