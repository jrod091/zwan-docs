# Product Features

zWAN is Amzetta’s implementation of SDWAN solution. zWAN is targeted towards small to midsize enterprises that are looking to incorporate SDWAN into their networking infrastructure. 

Amzetta’s zWAN is composed of two major parts
- A centralized management/orchestration server (or cluster of servers) director is responsible for the management plane and certain control plane activities. 
- Edge controller management and configuration with Director.

## Features
- Standalone and HA Support.
- [Edge Controller management by zero touch provisioning and secure shell](/Director_FSD/Onboarding/%20EC_Onboarding_via_ProvisionServer_01.md)
- Web Client of Edge Controller
- [Monitoring and Reporting](/Director_FSD/Reporting/OnDemand_Reporting.md)
- CPE Backup and Restore
- Auto Policy and On Demand Policy
- Topology support – Hub and spoke, hybrid topologies
- Firmware update of Edge Controller
- Multi-tenancy
- Director Backup and Restore
- System Metrics for Director Server
- Debug Dump of Director
- External Syslog and ipfix
- zID Authentication
  - Active Directory and LDAP
  - Radius Server based authentication
  - Tacacs Server based authentication
  - Google Authentication
  - Mullti-factor authentication
- Clustered Management and Orchestration Servers
  - Failover, load balancing.