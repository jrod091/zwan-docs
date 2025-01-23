# Please verify the following configuration:

- PATHMTU, MSSFIX
- Packet fragmentation
- Link flapping
- DDoS
- Firewall (DPI)
- Filtering
- IPS/IDS
- QoS Configuration
- Routing issues

## DDOS

- Check if DDOS is enabled on the WAN interface and if the packet arriving on the WAN interface has a source IP part of the spoof addresses
- Check if the IP is flagged for any type of attack or portscan.
    - IPs flagged as part of an attack are blocked for 5 minutes
    - IPs flagged as part of a portscan are blocked for 1 day.
    - If the administrator feels that this is not an attack, then the IP can be added to the IP Allowlist or the DDOS threshold limits can be increased.

## Firewall

- Check the Firewall -> SDWAN_FORWARD chain if any rule could cause the packet to be dropped

## Filtering

- Check if the IP subnet is added under the IP Block List
- Check if the mac address is added under MAC Filtering


## IPS/IDS

- Check the IPS/IDS Alerts to see if the packet was flagged as a threat

## Routing Issues

### Branch to Branch and Branch to Branch via DC connectivity issues

- In the NetBalancer configuration, ensure the gateway IP address matches the branch's specific tunnel IP. An incorrect gateway IP will misdirect data packets, preventing them from reaching their intended destination. Verify the same on the NetBalancer page.

- Ensure the LAN subnets are do not overlap across branches in the network layout if using NetBalancer to achieve LAN to LAN communication. Verify this on the Interfaces pages of the branches


