# Server requirements for zWAN Director.

## Hardware requirements

### Standalone Server Configuration

- Single server with the below configuration is recommended
  - Ubuntu Server/Desktop OS version 22.04
  - Storage - 256GB
  - RAM - 64GB
  - CPU - 16 cores
  - Two to Three 1 Gig Network Interfaces

### Cluster Servers Configuration

- Three servers with the below configuration are recommended
  - Ubuntu Server/Desktop OS version 22.04
  - Storage - 256GB
  - RAM - 64GB
  - CPU - 16 cores
  - Three to Four 1Gig Network Interfaces
    - 2 for LAN side – Connected to a switch. These interfaces need to be up and IP need not be assigned for them.
    - One or two for WAN

## Software requirements

- Operating System
  - Ubuntu 22.04 (Recommended)
  - Ubuntu 18.04 (Support will be removed soon)
- Services
  - SSH - Secure shell service
  - Port 22 enabled.
- Packages
  - apt manager (apt update and apt upgrade should work)
  - python-apt (sudo apt install python-apt)
