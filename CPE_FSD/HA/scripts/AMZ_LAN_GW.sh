#!/bin/bash
trap "exit 1" TERM
export TOP_PID=$$
IP=$1
PORT=$2

if [ -z "$IP" ] || [ -z "$PORT" ]; then
    echo "Please enter IP and PORT"
    exit 22
fi

COMMON=(-X POST http://$IP:$PORT/graphql -H "Content-Type:application/json")

function execute_cmd(){
    array=("$@")
    str="{\"query\":"\"${array[@]}\""}"
    result=$(curl ${COMMON[@]} -d "${str[@]}" 2> /dev/null)
    if [ $? == 0 ]; then
        echo "${result}" | grep \"success\":false
        if [ $? == 0 ]; then
            echo "Failure to execute curl command" [${COMMON[@]}] [${str[@]}]  ${result} 1>&2
            kill -s TERM $TOP_PID
        fi
    else
        echo "Failure to execute curl command" [${COMMON[@]}] [${str[@]}] ${result} 1>&2
        kill -s TERM $TOP_PID
    fi
}

execute_cmd 'mutation { updateInterfaceFromManifest( name: \"ETH01\", interfaceMode: LAN, aliasName: \"LAN00\", additionalDescription: \"DIAB LAN KVM NIC\" ){code, message, success}}'
execute_cmd 'mutation { updateInterfaceFromManifest( name: \"ETH02\", interfaceMode: WAN, aliasName: \"WAN00\", additionalDescription: \"DIAB WAN KVM NIC\" ){code, message, success}}'
execute_cmd 'mutation { updateInterfaceFromManifest( name: \"ETH03\", interfaceMode: WAN, aliasName: \"WAN01\", additionalDescription: \"DIAB WAN KVM NIC\" ){code, message, success}}'
execute_cmd 'mutation { updateInterfaceFromManifest( name: \"ETH04\", interfaceMode: LAN, aliasName: \"LAN01\", additionalDescription: \"DIAB LAN KVM NIC\" ){code, message, success}}'

### Configure public interfaces -----------------------------------------------------
# isp1 static ip
execute_cmd 'mutation{ addIP( name: \"WAN00\", ip: { ipv4: { address: \"10.141.0.5\", netmask:\"255.255.255.0\" } }, gateway:\"10.141.0.99\" ){ code, message, success } }'
# isp2 static ip
execute_cmd 'mutation{ addIP( name: \"WAN01\", ip: { ipv4: { address: \"10.142.0.5\", netmask:\"255.255.255.0\" } }, gateway:\"10.142.0.99\" ){ code, message, success } }'
# amz-gateway static ip
execute_cmd 'mutation{ addIP( name: \"LAN01\", ip: { ipv4: { address: \"10.99.0.1\", netmask:\"255.255.255.0\" } }, status:UP ){ code, message, success } }'

# nat
execute_cmd 'mutation{ enableNATInterfaces(interfaces: [\"WAN00\", \"WAN01\"]){ code, message, success} }'

#default gateway
execute_cmd 'mutation { setDefaultGateway(viaGateway: \"10.141.0.99\") {code,success,message} }'

## Enabled IPForwardng and Syslog
execute_cmd 'mutation{enableDisableIPForwarding(enabled:true){code,message,success}}'
execute_cmd 'mutation{addRemoteLogServerInfo(remoteLogServer:{configuredState:Enabled, remoteServerIP: \"192.168.128.1\", port: 5000, protocol: \"UDP\"}){ code, message, success} }'

# IPFIX for netflow and twamp
execute_cmd 'mutation{ addIPFixCpe(ipFixCpe:{configuredState:Enabled, collectorIP: \"192.168.128.1\", udpPort: 2055, tcpPort: 4739}){code, message, success, ipFixCpe{collectorIP, configuredState, tcpPort, udpPort} } }'
execute_cmd 'mutation{enableDisableIpfix(configuredState:Enabled, serviceName: netflow){code, message, success, ipfixInfo{configuredState, collectorIP, tcpPort, udpPort } } }'
execute_cmd 'mutation{enableDisableIpfix(configuredState:Enabled, serviceName: twamp){code, message, success, ipfixInfo{configuredState, collectorIP, tcpPort, udpPort } } }'

### LAN DHCP -----------------------------------------------------
# set IP for LAN port
execute_cmd 'mutation { addIP(name: \"LAN00\", ip: { ipv4: { address: \"172.67.0.1\", netmask: \"255.255.255.0\" } }, status:UP ) {code,success,message} }'
# select network that needs dhcp
execute_cmd 'mutation { createDhcpSubnet(network:\"172.67.0.0\", netmask: \"255.255.255.0\" ) {code,success,message} }'
# define ip range for dhcp
execute_cmd 'mutation { saveDhcpSubnet(subnetId:\"00\", gateway: \"172.67.0.1\", dns: [\"8.8.8.8\"], defaultDuration:{ days:365, hours:0, minutes:0 }, maxDuration:{ days:365, hours:0, minutes:0 }, configuredStatus: true, ipRange: [{start:\"172.67.0.100\", end:\"172.67.0.200\"}]) {code,success,message} }'
