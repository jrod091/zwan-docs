# DNS Configuration and Filtering Guide

## DNS Configuration

### 1. LAN Interface / Tunnel Interface
- Identify the LAN interface(s) that require DNS services.
  - For example, in a Branch setup, the LAN interface may require DNS.
  - For example, in a IB2DC setup, in DC, the Tunnel interface would require DNS.
  
### 2. Subnet-Specific DNS Settings
- A LAN interface may have multiple subnets, including the one managed by the LAN interface.
- Specify the subnets behind each LAN interface that require DNS resolution.

### 3. DNS Resolver
- Configure the forward zone to define the DNS resolver:
  - Options: External DNS resolvers (e.g., `dns.quad9.net`) or the Tunnel interface IP in a DC.
  - Optionally enable security protocols for secure DNS resolution.

### 4. EC DNS Configuration
- Set the Edge Controller IP as the DNS server in the DHCP configuration page.

### 5. Browser DNS Management
- Ensure client browsers (e.g., Firefox) are managed by the organization.
- Configure browsers to use the **EC DNS** and avoid defaulting to custom or public DNS servers.

---

## DNS Filter (Third-Party)

### 1. System Requirements
- Requires systems with **2GB or more RAM**.

### 2. Purpose
- Used to block specific categories during DNS resolution.

### 3. Configuration
- Enable the DNS filter.
- Select the appropriate DNS repository.
- Configure the categories to block during DNS resolution.

### 4. Custom Lists
- **Allow List**: Explicitly allow domains, overriding DNS filter rules.
- **Block List**: Explicitly block domains not included in the DNS filter repository.
  - Domains in the block list will not resolve, effectively preventing access.

---

## Top 3500 Custom Domain Filtering (Provided by Amzetta)

### 1. Overview
- Includes approximately **25 categories** and **3500 FQDNs**.
- Designed for systems with **1GB RAM**.

### 2. Blocking and Allowing
- Block or allow domains by **category** or individual **FQDN**:
  - **Block Category**: Explicitly allow specific FQDNs within the blocked category.
  - **Allow Category**: Explicitly block specific FQDNs within the allowed category.

### 3. DNS Resolution Cycle
- DNS resolution occurs, and the LAN client receives an IP address.  
- However, access to blocked sites is denied during the request phase.

### 4. Added Advantage
- Enables **traffic steering** because the resolved IP for the FQDN is available.



