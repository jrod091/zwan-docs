# zWAN Director DC - DR site

## Introduction

zWAN support DC-DR to ensure continuous operation of orchestration server in event of disaster at DC site.

- Director DC is the primary server that host the centralized orchestration server to manage the CPE DC and branches.
- Director DR is the secondary server that serves a backup to primary server in the event of disaster and ensures continuous operation. DR site is typically located at a separate geographical location from the DC site.

zWAN solution support DC-DR in active passive mode. ie Only one site will be active at a time.

## Requirements

zWAN solution support DC-DR in [Cluster mode](/Director_Installation/Deployment/DirectorCluster.md)(HA) and standalone mode as below.

- DC (Cluster mode) and DR(Cluster mode)
- DC (Cluster mode) and DR(Standalone mode)
- DC (Standalone mode) and DR(Standalone mode)

The hardware requirements for [Cluster mode](/Director_Installation/Deployment/DeploymentUserGuide.md#22-ha-setup) and [Standalone mode](/Director_Installation/Deployment/DeploymentUserGuide.md#21-standalone-setup).

## Configuration

### Installation/Setup

- Setup the DC site as per the [deployment](/Director_Installation/Deployment/DeploymentUserGuide.md) user guide
- Setup the DR site as per the [deployment](/Director_Installation/Deployment/DeploymentUserGuide.md) user guide
- Schedule the backup of configuration and logs of DC site as per [backup and restore](/Director_Installation/Deployment/DBBackupRestore/DBBackupRestore.md) user guide

Note : The backup site should not be same as DC or DR.

## Switching Sites on failover and failback.

Switching sites from DC to DR and vice versa is a manual process with help of a script.

zWAN support DC DR in two modes.

- With FQDN (Recommended)
- Without FQDN

### Switch from DC to DR

Switching site of the site is invoked using the script, which involves below mentioned steps.

- DC Site(If accessible)
  - Change the DC site as passive
  - Take the backup of configuration and logs data and save it to remote site.
- DR Site
  - Stop(if running) all the service that access the database.
  - Restore the configuration and logs from latest successfully backed update.
  - Start the all the service that were stopped in previous step.
  - Change the management URL to DR IP address in provision server.
  - Change the tunnel server IPs to DR site IP address in director.
  - Set the DR site as active.

Follow the below steps to invoke the site switching.

1.  Set the Server IP to DC Server in master.yml file and run the script as below.

```
#./setup.sh [standalone] dc_to_dr

If DC server is standalone server specify standalone as second argument
```

1.  Set the Server IP to DR server in master.yml fine and run the script as below.

```
#./setup.sh [standalone] dc_to_dr

If DC server is standalone server specify standalone as second argument
```

1.  Switch the server

#### FQDN method

In this mode FQDN is used to switch the director server from DC site to DR site.

- Change DNS of the director from DC site to DR site.

#### Non FQDN method

When FQDN method is not possible IP address of DR should be set in Provisioning server and Edge controllers.

- Change the management URL to DR IP address in provision server.

### Switch from DR to DC

Switching from DR to DC also follows the same steps with DC and DR interchanged.

1.  Set the Server IP to DR Server in master.yml file and run the script as below.

```
#./setup.sh [standalone] dr_to_dc

If DR server is standalone server specify standalone as second argument
```

1.  Set the Server IP to DC server in master.yml fine and run the script as below.

```
#./setup.sh [standalone] dr_to_dc

If DC server is standalone server specify standalone as second argument
```

1.  Switch the server

#### FQDN method

- Change DNS of the director from DR site to DC site.

#### Non FQDN method

- Change the management URL to DC IP address in provision server.
