# DC-HA

## Overview: 

In any SDWAN solutions, availability of DC is always more critical.
As an interim solution, we support only ACTIVE-PASSIVE mode in DC.
In this design, there will be only two DC's per tenant in the HA cluster and there will be a Gateway node through which both the DC's reach their LAN network.

All the DC's will have public IP [WAN] as an endpoint through which all the branches will establish their IPSEC tunnels.
And the tunnels are usually one to many from DC.  So, if the ACTIVE DC fails that failure needs to be informed to all of their branches and reestabilish the connection from the PASSIVE DC.

As of today, topology has the all the details about both the branches and their DCs w.r.t tunnels.

So, we have created a new micro-service named __*dc-monitor*__, that checks the livelyness of ACTIVE DC and collects the topology for every few [*say 20*] seconds.  If the __*dc-monitor*__ detects any failure, then it checks for any passive DC is available to takeover.  If that is available, then the __*dc-monitor*__ informs all the branches to connect to the PASSIVE DC and change its state to new ACTIVE.

During these switchover, the LAN behind the DC's should reach the branches through new ACTIVE DC.  Someone needs to inject the reverse route here, we are achieving this by having our vCPE as Gateway node that connects both the ACTIVE and PASSIVE DCs and all the DC-LAN traffic is reached through that Gateway.  Also OSPF is configured between DC-ACTIVE, DC-PASSIVE and Gateway node, so that the reverse routed is injected seamlessly without any isuses even during DC failover and failback.

Please see the overview of our setup as shown in the *figure* below:

For this Test case , IN DC A and DC B the tunnel should get created with different Tunnel ID so that  once the FOFB happened the branch Tunnel ID get changed with current active server tunnel ID.And for OSPF Interface if we are Planning with LAN interface itself then we may need to Enable LAN - LAN in router if its WAN then no need to enable that in AMZ_LAN_GW

![HA](images/dc-ha-overview.png)

## Setup Configuration:

Make sure that your setup is configured as shown in the *figure* above.
It has 5 main nodes:
- DC-A (HA_DC1 runs in ACTIVE mode)
- DC-P (HA_DC2 runs in Passive mode)
- AMZ-Gateway (AMZ_LAN_GW node behind DC nodes)
- BR-1 (Branch 1)
- BR-2 (Branch 2)

1) Onboard AMZ_LAN_GW, HA_DC1, HA_DC2, BR1 & BR2 CPE's from secure shell. After onboarded, the Alpsee UI should list like shown below:

    __NOTE:__
    *Make sure that __dc_monitor__ micro-service is running in the onboarding provider, without that HA will not function.*

    - While onboarding, add the __metadata__ to differentiate DC and BR CPE's.

    ```
    For HA_DC1 --> CPE_TYPE = DC, CPE_MODE = HA, HA_STATE = ACTIVE
    For HA_DC2 --> CPE_TYPE = DC, CPE_MODE = HA, HA_STATE = PASSIVE
    ```

    ![Onboarded CPE](images/dc_metadata.png)

    ```
    For both BR --> CPE_TYPE = BR
    ```

    ![Onboarded CPE](images/br_metadata.png)

    - After onboarding everything, __list__ all the edge controllers

    ![Onboarded CPE](images/onboarded_cpes.png)

6) Now configure the OSPF in AMZ_LAN_GW, HA_DC1 & HA_DC2 CPE's [*for reverse route injection*]

## OSPF Configuration

```
Please Configure OSPF on AMZ_GATEWAY with the below mentioned steps:
```

1) Enable OSPF

    ![Onboarded CPE](images/enable_ospf.png)

2) Add the RouterID

    ![Onboarded CPE](images/amz_router_id.png)

3) Add new area [__*For recommended settings create an area with 0 in any of the device*__]

    ![Onboarded CPE](images/add_area.png)

4) Add active interface through which the routes are learned and select the network type as __*point_to_multipoint*__

    ![Onboarded CPE](images/amz_add_interface-1.png)

5) Add passive interface through which the DC LAN servers are reachable and select the network type as __*broadcast*__

    ![Onboarded CPE](images/amz_add_interface-2.png)


```
Please Configure OSPF on DC-A with the below mentioned steps:
```

1) Enable OSPF

    ![Onboarded CPE](images/enable_ospf.png)

2) Add the RouterID

    ![Onboarded CPE](images/dc1_router_id.png)

3) Add the redistribution for all kernel routes

    ![Onboarded CPE](images/route_redistribution.png)

4) Add new area

    ![Onboarded CPE](images/add_area.png)

4) Add active interface through which the routes are learned and select the network type as __*point_to_multipoint*__

    ![Onboarded CPE](images/dc_add_interface.png)


```
Please Configure OSPF on DC-P with the below mentioned steps:
```

1) Enable OSPF

    ![Onboarded CPE](images/enable_ospf.png)

2) Add the RouterID

    ![Onboarded CPE](images/dc2_router_id.png)

3) Add the redistribution for all kernel routes

    ![Onboarded CPE](images/route_redistribution.png)

4) Add new area

    ![Onboarded CPE](images/add_area.png)

4) Add active interface through which the routes are learned and select the network type as __*point_to_multipoint*__

    ![Onboarded CPE](images/dc_add_interface.png)


## Verify the OSPF config

As shown in the overview, both the branches connects to DC-A, so all the DC Servers should go through DC-A to reach any branch or branch lans.

- OSPF route in AMZ_GATEWAY [External routes are learned from DC-A]

    ![Onboarded CPE](images/amz_ospf_route.png)

- OSPF route in DC-A [External routes will be empty, as DC-A is active right now]

    ![Onboarded CPE](images/dc1_ospf_route.png)

- OSPF route in DC-B [External routes are learned from DC-A]

    ![Onboarded CPE](images/dc2_ospf_route.png)


## Make sure the routes are fine by running IOs

- Check the routes in all the CPEs [AMZ_GATEWAY, DC-A, DC-B, BR-1 & BR-2]

    ![Onboarded CPE](images/routes_all_cpe.png)

- Login to each LAN-PCs and make sure that all got the IPS leased from CPEs

    __BR-1 LAN PCs:__

    ![Onboarded CPE](images/br1_lan_pcs.png)

    __BR-2 LAN PCs:__

    ![Onboarded CPE](images/br2_lan_pcs.png)

    __DC LAN Servers:__

    ![Onboarded CPE](images/dc_lan_servers.png)

- Start the IOs from all the branch lan pcs and monitor the same using tcpdump in dc lan servers

    __BR-1 LAN running IOs:__

    ![Onboarded CPE](images/br1_lan_ios.png)

    __BR-2 LAN running IOs:__

    ![Onboarded CPE](images/br2_lan_ios.png)


    __DC LAN running tcpdumps:__

    ![Onboarded CPE](images/dc_lan_tcpdump.png)
