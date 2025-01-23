# IPSEC Tunnel not establishing 

- Check if the IP addresses used are part of spoof addresses when DDOS is enabled on the WAN Interface
    - This use case is when the EC WANs are on a private address space of ipaddress and not directly facing the Internet. If so, navigate to the Security->DDOS page and remove the private address range from spoof address list.

- Check the Remote IP addresses are reachable.
    - Use the ping option on the Utility page to verify the same

- Check the ports used (500 & 4500 or custom remote port) for the Tunnel creation are opened.
    - In a usecase where there is a router(R1) in front of the EC, a port forward configuration should be enabled on that router(R1) to direct the ports to the respective WAN on the EC. The firewall config on that router(R1) should also open up the ports.

- Encryption and IKE algorithms should match on both ends.
    - Verify the same by comparing the tunnel information on both ends using the "Info" icon on the respective tunnel.

- Local LAN and Tunnel subnets should be specified in the allowed subnets.

- Make sure the certificates have not expired
    - Verify the Status by navigating to the Security->x509 page for the respective certificates used.

- If using custom HOST certificates, make sure the CA certificate who has issued the HOST certificates is imported on both ends.

- Make sure the interface for the LAN subnets advertised in local subnets are enabled

# Advanced Debugging options

## Enable IPSEC logs on the EC

- IPSEC logs are default disabled on the EC due to flooding of log messages for even the lowest reporting level. To enable them use the secure shell and enter into the console. This operation is to be performed only by Amzetta Support.

Edit the file /etc/strongswan.d/charon-logging.conf. Change the default loglevel option from -1 to 1 under charon -> filelog ->  /var/log/ipsec.log

```
# Default loglevel.
default = 1
```

Save the file. Send a SIGHUP signal to the charon daemon

```
kill -SIGHUP `pidof charon`
```

## Disable IPSEC logs on the EC

To disable the log after debugging change the default loglevel back to -1 and send the SIGHUP to the charon daemon


## Debugging IPSEC logs

### Mismatching algorithms

#### Example 1

    May 31 15:26:49 13[CFG] received stroke: add connection 'IPSEC02'
    May 31 15:26:49 13[CFG] a PRF algorithm is mandatory in IKE proposals
    May 31 15:26:49 13[CFG] skipped invalid proposal string: aes256gcm16-aes256gmac-modp4096
    May 31 15:26:49 08[CFG] received stroke: route 'IPSEC02'
    May 31 15:26:49 08[CFG] no config named 'IPSEC02'
    May 31 15:26:49 06[CFG] received stroke: initiate 'IPSEC02'
    May 31 15:26:49 06[CFG] no config named 'IPSEC02'

#### Example 2

    Jun  3 12:53:03 01[NET] <5> received packet: from 10.132.0.4[500] to 10.132.0.3[500] (584 bytes)
    Jun  3 12:53:03 01[ENC] <5> parsed IKE_SA_INIT request 0 [ SA KE No N(NATD_S_IP) N(NATD_D_IP) N(FRAG_SUP) N(HASH_ALG) N(REDIR_SUP) ]
    Jun  3 12:53:03 01[IKE] <5> 10.132.0.4 is initiating an IKE_SA
    Jun  3 12:53:03 01[CFG] <5> received proposals: IKE:AES_GCM_16_256/PRF_HMAC_SHA2_256/MODP_3072
    Jun  3 12:53:03 01[CFG] <5> configured proposals: IKE:AES_GCM_16_256/PRF_HMAC_SHA2_256/MODP_4096
    Jun  3 12:53:03 01[IKE] <5> remote host is behind NAT
    Jun  3 12:53:03 01[IKE] <5> received proposals unacceptable
    Jun  3 12:53:03 01[ENC] <5> generating IKE_SA_INIT response 0 [ N(NO_PROP) ]

    
    Jun  3 12:53:27 10[IKE] <IPSEC00|419> initiating IKE_SA IPSEC00[419] to 10.132.0.3
    Jun  3 12:53:27 10[ENC] <IPSEC00|419> generating IKE_SA_INIT request 0 [ SA KE No N(NATD_S_IP) N(NATD_D_IP) N(FRAG_SUP) N(HASH_ALG) N(REDIR_SUP) ]
    Jun  3 12:53:27 10[NET] <IPSEC00|419> sending packet: from 10.132.0.4[500] to 10.132.0.3[500] (584 bytes)
    Jun  3 12:53:27 11[NET] <IPSEC00|419> received packet: from 10.132.0.3[500] to 10.132.0.4[500] (36 bytes)
    Jun  3 12:53:27 11[ENC] <IPSEC00|419> parsed IKE_SA_INIT response 0 [ N(NO_PROP) ]
    Jun  3 12:53:27 11[IKE] <IPSEC00|419> received NO_PROPOSAL_CHOSEN notify error

    
    Jun  3 12:53:51 07[ENC] <IPSEC00|422> parsed CREATE_CHILD_SA request 0 [ SA No KE TSi TSr ]
    Jun  3 12:53:51 07[CFG] <IPSEC00|422> received proposals: ESP:AES_GCM_16_256/MODP_3072/NO_EXT_SEQ
    Jun  3 12:53:51 07[CFG] <IPSEC00|422> configured proposals: ESP:AES_GCM_16_256/MODP_4096/NO_EXT_SEQ
    Jun  3 12:53:51 07[IKE] <IPSEC00|422> no acceptable proposal found
    Jun  3 12:53:51 07[IKE] <IPSEC00|422> failed to establish CHILD_SA, keeping IKE_SA
    Jun  3 12:53:51 07[ENC] <IPSEC00|422> generating CREATE_CHILD_SA response 0 [ N(NO_PROP) ]

### Example 3 : Encryption algorithms not matching


    Jun  3 13:04:47 13[IKE] <IPSEC00|425> establishing CHILD_SA IPSEC00{1558}
    Jun  3 13:04:47 13[ENC] <IPSEC00|425> generating CREATE_CHILD_SA request 2 [ SA No KE TSi TSr ]
    Jun  3 13:04:47 13[NET] <IPSEC00|425> sending packet: from 10.132.0.4[4500] to 10.132.0.3[4500] (721 bytes)
    Jun  3 13:04:47 15[NET] <IPSEC00|425> received packet: from 10.132.0.3[4500] to 10.132.0.4[4500] (65 bytes)
    Jun  3 13:04:47 15[ENC] <IPSEC00|425> parsed CREATE_CHILD_SA response 2 [ N(NO_PROP) ]
    Jun  3 13:04:47 15[IKE] <IPSEC00|425> received NO_PROPOSAL_CHOSEN notify, no CHILD_SA built
    Jun  3 13:04:47 15[IKE] <IPSEC00|425> failed to establish CHILD_SA, keeping IKE_SA


### Remote IP has changed but branch still pointing to old IP

    Feb 23 17:56:07 08[IKE] <IPS01azbu0o01|33> initiating IKE_SA IPS01azbu0o01[33] to 172.31.2.77
    Feb 23 17:56:07 08[ENC] <IPS01azbu0o01|33> generating IKE_SA_INIT request 0 [ SA KE No N(NATD_S_IP) N(NATD_D_IP) N(FRAG_SUP) N(HASH_ALG) N(REDIR_SUP) ]
    Feb 23 17:56:07 08[NET] <IPS01azbu0o01|33> sending packet: from 172.31.2.64[500] to 172.31.2.77[500] (592 bytes)
    Feb 23 17:56:07 14[NET] <IPS01azbu0o01|33> received packet: from 172.31.2.77[500] to 172.31.2.64[500] (36 bytes)
    Feb 23 17:56:07 14[ENC] <IPS01azbu0o01|33> parsed IKE_SA_INIT response 0 [ N(NO_PROP) ]
    Feb 23 17:56:07 14[IKE] <IPS01azbu0o01|33> received NO_PROPOSAL_CHOSEN notify error


### CA Certificate missing

    Feb 23 17:36:28 15[CFG] <IPSMWAN00|11>   using certificate "C=US, ST=Georgia, L=Norcross, O=admin, OU=CPE Unit, CN=c-Bqc5_4e8u4a_WAN00_dio8u, E=cpe_admin@amzetta.com"
    Feb 23 17:36:28 15[CFG] <IPSMWAN00|11> no issuer certificate found for "C=US, ST=Georgia, L=Norcross, O=admin, OU=CPE Unit, CN=c-Bqc5_4e8u4a_WAN00_dio8u, E=cpe_admin@amzetta.com"
    Feb 23 17:36:28 15[CFG] <IPSMWAN00|11>   issuer is "C=US, ST=Georgia, L=Norcross, O=zwan-tenant, OU=CPE Unit, CN=zwan-tenant, E=cpe_admin@zwan-tenant.com"
    Feb 23 17:36:28 15[IKE] <IPSMWAN00|11> no trusted RSA public key found for 'C=US, ST=Georgia, L=Norcross, O=admin, OU=CPE Unit, CN=c-Bqc5_4e8u4a_WAN00_dio8u, E=cpe_admin@amzetta.com'
    Feb 23 17:36:28 15[ENC] <IPSMWAN00|11> generating IKE_AUTH response 1 [ N(AUTH_FAILED) ]

### Traffic Selectors mismatch due to overlapping local subnets across different branches 

IPSEC Connection may show as established but NetBalancer is still faulty, this could be due to a local lan subnet specified in IPSEC alloweb subnets overlapping with another branch local subnet. The IPSEC connected clients will show the red status for the connection.

    Sep 20 11:58:04 06[ENC] <IPSEC00|9> parsed CREATE_CHILD_SA response 113 [ N(TS_UNACCEPT) ]
    Sep 20 11:58:04 06[IKE] <IPSEC00|9> received TS_UNACCEPTABLE notify, no CHILD_SA built
    Sep 20 11:58:04 06[IKE] <IPSEC00|9> failed to establish CHILD_SA, keeping IKE_SA

# Known Restrictions

- IKEv1 is not supported as it does not support multiple source IP ranges / subnets as part of the  allowed subnet field

- NAT and Compression are not supported when using IPSEC in AH mode
