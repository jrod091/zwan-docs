# NetBalancer gateways displaying Faulty / Inactive

## Please verify the following configuration

- When using WAN interfaces for Internet, Tunnel or SAAS breakout, they should have ICMP failover with reachable public IP addresses as part of the configuration. Gateway IPs for Internet and SAAS can overlap when using WAN interfaces.

- When using Tunnel interfaces for Internet breakout, provide the proper remote gateway ip for reaching the remote LAN. Remote tunnel gateway ips would be unqiue to branch and across branches.

- LTE interfaces not displaying the correct gateway IP : Please enable/disable the NB gateway

- Branches which use the LTE interface gateways should always use ICMP failover as the LTE gateway may not allow ping or arping.

- If a NetBalancer gateway is using an LTE interface and shows as faulty, please make sure the LTE has active postpaid data plan and has not exceeded the data limit usage for the month. The same applies for a pre-paid data plan. This information would be available on the account login on the LTE website.

- Some LTE providers block certain traffic like IPSEC or UDP or ICMP, so please confirm with the LTE vendor that traffic is not blocked.

- When using IB and Tunnels, please make sure the tunnels are assigned the proper affinity to the IB gateways.

- In an IB to DC configuration, please make sure the tunnels to reach the DC are assigned proper affinity to the Branch gateways to reach the DC. The DC ips should be publicly reachable.

- Remote LAN should be unique across branches and not overlap unless its a Internet or SAAS breakout

- IPSEC tunnel showing established but the corresponding NB gateway showing faulty
    - Please check the connections on the IPSEC tunnel to make sure the respective endpoint shows as green with a remote subnet
    - Make sure the tunnel IP is unique across ECs in the same network topology

## Advanced options

- When NetBalancer is not detecting faults over any configured gateway or new gateways ips are not getting updated automatically for LTE or DHCP networks, use the Advanced options to restart the link monitor for Netbalancer. Please note this would disrupt all traffic flowing through all channels on the EC for a few minutes.

