# SSLVPN Tunnel not establishing

- Verify if the time is in sync on both EC endpoints of the tunnel.

- Check if the IP addresses used are part of spoof addresses when DDOS is enabled on the WAN Interface
    - This use case is when the EC WANs are on a private address space of ipaddress and not directly facing the Internet. If so, navigate to the Security->DDOS page and remove the private address range from spoof address list.

- Check the Remote IP addresses are reachable.
    - Use the ping option on the Utility page to verify the same

- Check the ports used for the Tunnel creation are opened.
    - In a usecase where there is a router(R1) in front of the EC, a port forward configuration should be enabled on that router(R1) to direct the ports to the respective WAN on the EC. The firewall config on that router(R1) should also open up the ports.

- SSL VPN Server side (DC) should have x509 Server certificate and the Branch side (BR) should have x509 client certificate

- Make sure the certificates have not expired
    - Verify the Status by navigating to the Security->x509 page for the respective certificates used.

- If using custom HOST certificates, make sure the CA certificate who has issued the HOST certificates is imported on both ends.

- Encryption and Compression option should match on both endpoints.

- Check the logs for certificate verification failure under syslog and respective tunnel from director UI.

```
    EC-System-Logs-SYSLOG-SSLVPN
        Mar  1 05:06:07 KETTOPESK VPN00_L2L[11965]: VERIFY ERROR: depth=0, error=unable to get local issuer certificate: C=US, ST=Georgia, L=Norcross, O=Amzetta Technologies LLC, OU=CPE Unit, CN=server01, emailAddress=dhina@amzetta.com
        Mar  1 05:06:07 KETTOPESK VPN00_L2L[11965]: OpenSSL: error:1416F086:SSL routines:tls_process_server_certificate:certificate verify failed
        Mar  1 05:06:07 KETTOPESK VPN00_L2L[11965]: TLS_ERROR: BIO read tls_read_plaintext error
        Mar  1 05:06:07 KETTOPESK VPN00_L2L[11965]: TLS Error: TLS object -> incoming plaintext read error
        Mar  1 05:06:07 KETTOPESK VPN00_L2L[11965]: TLS Error: TLS handshake failed
```

- Verify if all LAN subnets are reachable from the EC
    