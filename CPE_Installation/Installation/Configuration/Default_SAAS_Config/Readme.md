The scripts to create default config with IPSEC/SSLVPN tunnel on Branch and DC are ready and copied in Git.

BR: update the IP info in the script  and create 1 certificate before you run the script
DC: update the IP info in the script and create 2 certificate before you run the script

In BR: It will create IB, SaaS, Tunnels over 2 Wan, NB Gateway to DC, config DNS, Category, QoS, Steering
In DC: It will create IB, Two  1to2 many Tunnels (if not present), NB Gateway to BR, IPS

After running the script, BR to BR data communication in hub and spoke model over IPSEC/SSLVPN tunnel can be done.

