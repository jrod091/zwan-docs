#!/bin/bash
# shellcheck source=/dev/null
# shellcheck disable=SC2016
# DC configuration

#IMPORTANT NOTE: Create one Server Certicate using Director UI manually and make sure its the first certificate at index 00
#SCRIPT works only on VPN00 and VPN01

##data needed to reach internet from DC
export WAN00_VIA_GW="172.20.1.1"

##data needed to create VPN
export WAN00_localIP="172.20.1.50"
export TUN00_localIP="10.130.1.1"
export TUN00_remoteIP="10.130.1.3"

export VPN00_PORT="10001"

export TUN00_LEFT_SUBNET="0.0.0.0/0"

export vEC_LAN_NETWORK="192.168.34.0/24"
export vEC_BRANCH_NAME="TO_DEMOBPI_2"

##DNS Access Control
export DCLAN_INTERFACE="LAN00"
export DCLAN_DNS_AC="172.3.0.0/24"
export TUN00_DNS_AC="10.130.1.0/24"

export DNS_FILTER_REPO="https://zwandemo.amzetta.com:7080/minio/dns"

#TunnelType (1: IPSEC / 0: SSLVPN)
IPSEC=1

if [ ${IPSEC} == 1 ]; then
	export TUN00=IPSEC00

    RES=$(curl -X POST http://127.0.0.1:8765/graphql -H "Content-Type:application/json" --max-time 600 -d '{ "query" : "query {  security {  certificates(type:HOST, id:\"00\") { subjectText }  __typename  } }"}' | jq '.')
    if [[ "${RES}" =~ "ERROR" ]]; then
        echo -e "\nFailed in retrieving Certificate configuration, Cannot proceed further\n";
        exit 1
    else
        LEFT00_CERTID="$(echo ${RES} | jq -r '.data.security.certificates[0].subjectText' 2>/dev/null)"
    fi

    RES=$(curl -X POST http://127.0.0.1:8765/graphql -H "Content-Type:application/json" --max-time 600 -d '{ "query" : "query {  security {  certificates(type:HOST, id:\"01\") { subjectText }  __typename  } }"}' | jq '.')
    if [[ "${RES}" =~ "ERROR" ]]; then
        echo -e "\nFailed in retrieving Certificate configuration, Cannot proceed further\n";
        exit 1
    else
        LEFT01_CERTID="$(echo ${RES} | jq -r '.data.security.certificates[0].subjectText' 2>/dev/null)"
    fi

    if [ -z "${LEFT00_CERTID}" ] || [ -z "${LEFT01_CERTID}" ] || [ "${LEFT00_CERTID}" = "null" ] || [ "${LEFT01_CERTID}" = "null" ];  then
        echo -e "\nFailed to retrieve Certificate configuration, Cannot proceed further\n";
        exit 1
    fi

else
	export TUN00=VPN00
	
    RES=$(curl -X POST http://127.0.0.1:8765/graphql -H "Content-Type:application/json" --max-time 600 -d '{ "query" : "query {  security {  certificates(type:HOST, id:\"00\") { subjectText }  __typename  } }"}' | jq '.')
    if [[ "${RES}" =~ "ERROR" ]]; then
        echo -e "\nFailed in retrieving Certificate configuration, Cannot proceed further\n";
        exit 1
    else
        LEFT00_CERTID=$(echo ${RES} | jq -r '.data.security.certificates[0].subjectText' 2>/dev/null)
    fi

    if [ -z "${LEFT00_CERTID}" ] || [ ${LEFT00_CERTID} = "null" ]; then
        echo -e "\nFailed to retrieve Certificate configuration, Cannot proceed further\n";
        exit 1
    fi

fi

export IPS_REPO_URL="https://rules.emergingthreats.net/open/suricata-5.0.0/emerging.rules.tar.gz"

RES=$(curl -X POST http://127.0.0.1:8765/graphql -H "Content-Type:application/json"  -d '{ "query" : "query { network {netBalancer (branchName:\"Internet\") { branchName, type } } }" }'  | jq '.')
if [[ "${RES}" =~ "ERROR" ]]; then
    echo -e "\nFailed in retrieving Net Balancer configuration, Cannot proceed further\n";
    exit 1
else
    result=$(echo ${RES} | jq -r '.data.network.netBalancer[0].branchName' 2>/dev/null)
    if [ -n "${result}" ] && [ ${result} == "Internet" ]; then
        echo "Internet branch already present, continue"
    else
        #IB in DC
        ##via WAN00
        curl -X POST http://127.0.0.1:8765/graphql -H "Content-Type:application/json" --max-time 600 -d '{"variables":{"description":"IB via WAN00","destIP":"'${WAN00_VIA_GW}'","localInterface":"WAN00","configuredStatus":"UP","weight":3,"timeoutCoefficient":1,"type":"INTERNET","branchName":"","branchLan":""}, "query":"mutation addNBGateway($description: String!, $destIP: IPv4!, $localInterface: String!, $configuredStatus: NBGatewayStatus!, $weight: Int!, $timeoutCoefficient: Int!, $type: NBGatewayType!, $branchName: String, $branchLan: String) {  addNBGateway(description: $description, destIP: $destIP, localInterface: $localInterface, configuredStatus: $configuredStatus, weight: $weight, timeoutCoefficient: $timeoutCoefficient, type: $type, branchName: $branchName, branchLan: $branchLan) {  code  success  message  __typename  } } "}'

        ##saveNetBalancerConfig
        curl -X POST http://127.0.0.1:8765/graphql -H "Content-Type:application/json" --max-time 600 -d '{"variables":{"type":"INTERNET","branchName":null,"configuredStatus":"Enabled","mode":"LBFO","packetLB":false,"icmpCheck":"Enabled","probesUP":2,"probesDOWN":3,"pauseInterval":2,"icmpReplyTimeout":2,"pppdRestart":false,"foMonitorEnabledIP1":"Enabled","foMonitorIP1":"8.8.8.8","foMonitorEnabledIP2":"Disabled","foMonitorIP2":null,"foMonitorEnabledIP3":"Disabled","foMonitorIP3":null}, "query":"mutation saveNetBalancerConfig($type: NBGatewayType!, $branchName: String, $configuredStatus: EnabledDisabled!, $mode: NBMode!, $packetLB: Boolean!, $icmpCheck: EnabledDisabled!, $probesUP: Int, $probesDOWN: Int, $pauseInterval: Int, $icmpReplyTimeout: Int, $pppdRestart: Boolean, $foMonitorEnabledIP1: EnabledDisabled!, $foMonitorIP1: IPv4, $foMonitorEnabledIP2: EnabledDisabled!, $foMonitorIP2: IPv4, $foMonitorEnabledIP3: EnabledDisabled!, $foMonitorIP3: IPv4) {  saveNetBalancerConfig(type: $type, branchName: $branchName, configuredStatus: $configuredStatus, mode: $mode, packetLB: $packetLB, icmpCheck: $icmpCheck, probesUP: $probesUP, probesDOWN: $probesDOWN, pauseInterval: $pauseInterval, icmpReplyTimeout: $icmpReplyTimeout, pppdRestart: $pppdRestart, foMonitorEnabledIP1: $foMonitorEnabledIP1, foMonitorIP1: $foMonitorIP1, foMonitorEnabledIP2: $foMonitorEnabledIP2, foMonitorIP2: $foMonitorIP2, foMonitorEnabledIP3: $foMonitorEnabledIP3, foMonitorIP3: $foMonitorIP3) {  code  success  message  __typename  } } "}'
    fi
fi


#create VPN tunnel in DC

if [ ${IPSEC} == 1 ]; then
    echo ${LEFT00_CERTID}  
    echo ${LEFT01_CERTID}

    RES=$(curl -X POST http://127.0.0.1:8765/graphql -H "Content-Type:application/json" --max-time 600 -d '{ "query" : "query {  network {  listIPsec(tunnelName:\"IPSEC00\") { tunnelName }  __typename  } }"}' | jq '.')
    if [[ "${RES}" =~ "ERROR" ]]; then
        echo -e "\nFailed in retrieving IPSEC configuration, Cannot proceed further\n";
        exit 1
    else
        result=$(echo ${RES} | jq -r '.data.network.listIPsec[0].tunnelName' 2>/dev/null)
        if [ -n "${result}" ] && [ ${result} == "IPSEC00" ]; then
            echo "${TUN00} already exists, continue"
        else

            curl -X POST http://127.0.0.1:8765/graphql -H "Content-Type:application/json" --max-time 600 -d '{"variables":{"description":"DC via WAN00","tunnelUUID":"IPSEC00viaWAN00","left":"'${WAN00_localIP}'","right":"0.0.0.0","gateway":"0001","leftSubnet":"'${TUN00_LEFT_SUBNET}'","rightSubnet":"0.0.0.0/0","authType":"X509","type":"ESP","encrptionAlg":"aes256gcm16","integrityAlg":"sha512","dhGroup":"modp4096","lifeTime":"1h","ikeVersion":"ikev2","ikeEncrptionAlg":"aes256gcm16","ikeIntegrityAlg":"sha256","ikeDHGroup":"modp3072","ikeLifetime":"3h","dpdDelay":"30s","dpdTimeout":"150s","dpdAction":"restart","compress":"no","forceUdpEncaps":"yes","leftCert":"00","leftCertId":"'"${LEFT00_CERTID}"'","rightCertId":""}, "query":"mutation createIPsec($description: String!, $tunnelUUID: String!, $type: TunnelType!, $encrptionAlg: String!, $integrityAlg: String!, $dhGroup: String!, $leftSubnet: String, $rightSubnet: String, $lifeTime: String!, $ikeVersion: IKEversion!, $ikeMode: IKEmode, $ikeEncrptionAlg: String!, $ikeIntegrityAlg: String!, $ikeDHGroup: String!, $ikeLifetime: String!, $dpdDelay: String!, $dpdTimeout: String!, $dpdAction: DPDAction!, $left: String!, $right: String!, $authType: AuthenticationType!, $secrets: String, $leftCert: String, $leftCertId: String, $rightCertId: String, $compress: SetValue, $forceUdpEncaps: SetValue, $gateway: String!) {  createIPsec(description: $description, tunnelUUID: $tunnelUUID, type: $type, encrptionAlg: $encrptionAlg, integrityAlg: $integrityAlg, dhGroup: $dhGroup, leftSubnet: $leftSubnet, rightSubnet: $rightSubnet, lifeTime: $lifeTime, ikeVersion: $ikeVersion, ikeMode: $ikeMode, ikeEncrptionAlg: $ikeEncrptionAlg, ikeIntegrityAlg: $ikeIntegrityAlg, ikeDHGroup: $ikeDHGroup, ikeLifetime: $ikeLifetime, dpdDelay: $dpdDelay, dpdTimeout: $dpdTimeout, dpdAction: $dpdAction, left: $left, right: $right, authType: $authType, secrets: $secrets, leftCert: $leftCert, leftCertId: $leftCertId, rightCertId: $rightCertId, compress: $compress, forceUdpEncaps: $forceUdpEncaps, gateway: $gateway) {  code  success  message  ipsec {  description  __typename  }  __typename  } } "}'

            curl -X POST http://127.0.0.1:8765/graphql -H "Content-Type:application/json" --max-time 600 -d '{"variables":{"name":"'${TUN00}'","ip":{"ipv4":{"address":"'${TUN00_localIP}'","netmask":"255.255.255.0"}},"twampResponder":false}, "query":"mutation addIP($name: String!, $ip: IPTypeInfoInput!, $interfaceType: InterfaceType, $gateway: String, $dns: [String], $tag: Int, $twampResponder: Boolean) {  addIP(name: $name, ip: $ip, interfaceType: $interfaceType, gateway: $gateway, dns: $dns, tag: $tag, twampResponder: $twampResponder) {  success  code  message  __typename  } } "}'
        fi
    fi
else
    echo ${LEFT00_CERTID}

    RES=$(curl -X POST http://127.0.0.1:8765/graphql -H "Content-Type:application/json" --max-time 600 -d '{ "query" : "query {  network {  openVPNList(name:\"VPN00\") { name localInterface }  __typename  } }"}' | jq '.')
    if [[ "${RES}" =~ "ERROR" ]]; then
        echo -e "\nFailed in retrieving VPN configuration, Cannot proceed further\n";
        exit 1
    else
        result=$(echo ${RES} | jq -r '.data.network.openVPNList[0].name' 2>/dev/null)
        if [ -n "${result}" ] && [ ${result} == "VPN00" ]; then
            echo "VPN00 already exists, continue"
        else
            curl -X POST http://127.0.0.1:8765/graphql -H "Content-Type:application/json" --max-time 600 -d '{"variables":{"description":"Server WAN00","tunnelUUID":"SSLVPNviaWAN00","localIP":"'${WAN00_localIP}'","port":10001,"proto":"UDP","role":"Server","compression":true,"encryption":true,"parameters":"","authType":"X509","gateway":"0001","certId":"00"}, "query":"mutation createOpenVPN($description: String!, $tunnelUUID: String!, $localIP: String!, $remoteIP: String, $port: Int!, $proto: ProtoType!, $role: RoleType!, $remoteCN: String, $compression: Boolean!, $encryption: Boolean!, $parameters: String, $authType: AuthenticationType!, $psk: String, $gateway: String!, $certId: String) {  createOpenVPN(description: $description, tunnelUUID: $tunnelUUID, localIP: $localIP, remoteIP: $remoteIP, port: $port, proto: $proto, role: $role, remoteCN: $remoteCN, compression: $compression, encryption: $encryption, parameters: $parameters, authType: $authType, psk: $psk, gateway: $gateway, certId: $certId, certType: Imported) {  code  success  message  openVPN {  name  description  cert {  displayName  __typename  }  __typename  }  __typename  } } "}'

            curl -X POST http://127.0.0.1:8765/graphql -H "Content-Type:application/json" --max-time 600 -d '{"variables":{"name":"'${TUN00}'","ip":{"ipv4":{"address":"'${TUN00_localIP}'","netmask":"255.255.255.0"}},"twampResponder":true}, "query":"mutation addIP($name: String!, $ip: IPTypeInfoInput!, $interfaceType: InterfaceType, $gateway: String, $dns: [String], $tag: Int, $twampResponder: Boolean) {  addIP(name: $name, ip: $ip, interfaceType: $interfaceType, gateway: $gateway, dns: $dns, tag: $tag, twampResponder: $twampResponder) {  success  code  message  __typename  } } "}'
        fi
    fi
fi


#Create NB to REACH vEC

##via WAN00
curl -X POST http://127.0.0.1:8765/graphql -H "Content-Type:application/json" --max-time 600 -d '{"variables":{"description":"via Tunnel00","destIP":"'${TUN00_remoteIP}'","localInterface":"'${TUN00}'","configuredStatus":"UP","weight":1,"timeoutCoefficient":1,"type":"BRANCH","branchName":"'${vEC_BRANCH_NAME}'","branchLan":"'${vEC_LAN_NETWORK}'"}, "query":"mutation addNBGateway($description: String!, $destIP: IPv4!, $localInterface: String!, $configuredStatus: NBGatewayStatus!, $weight: Int!, $timeoutCoefficient: Int!, $type: NBGatewayType!, $branchName: String, $branchLan: String) {  addNBGateway(description: $description, destIP: $destIP, localInterface: $localInterface, configuredStatus: $configuredStatus, weight: $weight, timeoutCoefficient: $timeoutCoefficient, type: $type, branchName: $branchName, branchLan: $branchLan) {  code  success  message  __typename  } } "}'

##saveNetBalancerConfig
curl -X POST http://127.0.0.1:8765/graphql -H "Content-Type:application/json" --max-time 600 -d '{"variables":{"type":"BRANCH","branchName":"'${vEC_BRANCH_NAME}'","configuredStatus":"Enabled","mode":"LBFO","packetLB":true,"icmpCheck":"Disabled","probesUP":2,"probesDOWN":3,"pauseInterval":2,"icmpReplyTimeout":2,"pppdRestart":false,"foMonitorEnabledIP1":"Disabled","foMonitorIP1":null,"foMonitorEnabledIP2":"Disabled","foMonitorIP2":null,"foMonitorEnabledIP3":"Disabled","foMonitorIP3":null}, "query":"mutation saveNetBalancerConfig($type: NBGatewayType!, $branchName: String, $configuredStatus: EnabledDisabled!, $mode: NBMode!, $packetLB: Boolean!, $icmpCheck: EnabledDisabled!, $probesUP: Int, $probesDOWN: Int, $pauseInterval: Int, $icmpReplyTimeout: Int, $pppdRestart: Boolean, $foMonitorEnabledIP1: EnabledDisabled!, $foMonitorIP1: IPv4, $foMonitorEnabledIP2: EnabledDisabled!, $foMonitorIP2: IPv4, $foMonitorEnabledIP3: EnabledDisabled!, $foMonitorIP3: IPv4) {  saveNetBalancerConfig(type: $type, branchName: $branchName, configuredStatus: $configuredStatus, mode: $mode, packetLB: $packetLB, icmpCheck: $icmpCheck, probesUP: $probesUP, probesDOWN: $probesDOWN, pauseInterval: $pauseInterval, icmpReplyTimeout: $icmpReplyTimeout, pppdRestart: $pppdRestart, foMonitorEnabledIP1: $foMonitorEnabledIP1, foMonitorIP1: $foMonitorIP1, foMonitorEnabledIP2: $foMonitorEnabledIP2, foMonitorIP2: $foMonitorIP2, foMonitorEnabledIP3: $foMonitorEnabledIP3, foMonitorIP3: $foMonitorIP3) {  code  success  message  __typename  } } "}'


#IPS configuration
RES=$(curl -X POST http://127.0.0.1:8765/graphql -H "Content-Type:application/json" --max-time 600 -d '{"variables":{},"query":"{ network { listIPSConfig(instance: lan) { enabled } }}"}' | jq '.')
if [[ "${RES}" =~ "ERROR" ]]; then
    echo -e "\nFailed in retrieving IPS configuration, Cannot proceed further\n";
    exit 1
else
    result=$(echo ${RES} | jq -r '.data.network.listIPSConfig[0].enabled' 2>/dev/null)
    if [ -n "${result}" ] && [ ${result} == "true" ]; then
        echo "IPS already enabled, continue"
        #we have to update lan network with existing networks
        RES=$(curl -X POST http://127.0.0.1:8765/graphql -H "Content-Type:application/json" --max-time 600 -d '{"operationName":"listYAMLParams","variables":{},"query":"query listYAMLParams { network {   listYAMLParams(instance: lan) {     paramType     paramValue     __typename   }   __typename }}"}')

        result=$(echo ${RES} | jq -r '.data.network.listYAMLParams' | jq -c '.[] | select(.paramType=="AMZ_HOME_NET")' |  jq -r '.paramValue'  2>/dev/null )
        if [ -n "${result}" ]; then
            vEC_LAN_NETWORK="${result},${vEC_LAN_NETWORK}"
            curl -X POST http://127.0.0.1:8765/graphql -H "Content-Type:application/json" --max-time 600 -d '{"variables":{"instance":"lan","ipsYAMLEntry":[{"paramType":"AMZ_HOME_NET","paramValue":"'${vEC_LAN_NETWORK}'"}]}, "query":"mutation setIPSYAMLParams($instance: IPSInstance!, $ipsYAMLEntry: [IPSYAMLEntryInput!]!) {  setIPSYAMLParams(instance: $instance, ipsYAMLEntry: $ipsYAMLEntry) {  code  message  success  __typename  } } "}'

            curl -X POST http://127.0.0.1:8765/graphql -H "Content-Type:application/json" --max-time 600 -d '{"variables":{"instance":"lan"}, "query":"mutation saveAndReloadIPS($instance: IPSInstance!) {  saveAndReloadIPS(instance: $instance) {  code  success  message  __typename  } } "}'
        fi
    else
        vEC_LAN_NETWORK="${DCLAN_DNS_AC},${vEC_LAN_NETWORK}"

        curl -X POST http://127.0.0.1:8765/graphql -H "Content-Type:application/json" --max-time 600 -d '{"variables":{"enabled":true,"instance":"lan"}, "query":"mutation enableDisableIPS($enabled: Boolean!, $instance: IPSInstance!) {  enableDisableIPS(enabled: $enabled, instance: $instance) {  code  success  message  __typename  } } "}'

        curl -X POST http://127.0.0.1:8765/graphql -H "Content-Type:application/json" --max-time 600 -d '{"variables":{"instance":"lan","ipsYAMLEntry":[{"paramType":"AMZ_HOME_NET","paramValue":"'${vEC_LAN_NETWORK}'"}]}, "query":"mutation setIPSYAMLParams($instance: IPSInstance!, $ipsYAMLEntry: [IPSYAMLEntryInput!]!) {  setIPSYAMLParams(instance: $instance, ipsYAMLEntry: $ipsYAMLEntry) {  code  message  success  __typename  } } "}'

        curl -X POST http://127.0.0.1:8765/graphql -H "Content-Type:application/json" --max-time 600 -d '{"variables":{"policyPriority":[{"priority":"high","action":"drop"}]}, "query":"mutation setIPSPolicyPriority($policyPriority: [IPSPolicyPriorityInput!]!) {  setIPSPolicyPriority(instance: lan, policyPriority: $policyPriority) {  code  success  message  __typename  } } "}'

        curl -X POST http://127.0.0.1:8765/graphql -H "Content-Type:application/json" --max-time 600 -d '{"variables":{"policyPriority":[{"priority":"medium","action":"drop"}]}, "query":"mutation setIPSPolicyPriority($policyPriority: [IPSPolicyPriorityInput!]!) {  setIPSPolicyPriority(instance: lan, policyPriority: $policyPriority) {  code  success  message  __typename  } } "}'

        curl -X POST http://127.0.0.1:8765/graphql -H "Content-Type:application/json" --max-time 600 -d '{"variables":{"urls":[{"url":"'${IPS_REPO_URL}'","urlID":null,"description":"Suricata rules","enabled":1}]}, "query":"mutation addIPSProviderURL($urls: [IPSProviderInput!]!) {  addIPSProviderURL(urls: $urls) {  code  success  message  __typename  } } "}'

        curl -X POST http://127.0.0.1:8765/graphql -H "Content-Type:application/json" --max-time 600 -d '{"variables":{"instance":"lan"}, "query":"mutation saveAndReloadIPS($instance: IPSInstance!) {  saveAndReloadIPS(instance: $instance) {  code  success  message  __typename  } } "}'

        curl -X POST http://127.0.0.1:8765/graphql -H "Content-Type:application/json" --max-time 600 -d '{"variables":{"controllerMode":"CUSTOM","ingressInterface":["WAN00"],"egressInterface":["'${TUN00}'","'${DCLAN_INTERFACE}'"]}, "query":"mutation setIPSInterface($controllerMode: IPSControllerMode!, $ingressInterface: [String!], $egressInterface: [String!]) {  setIPSInterface(controllerMode: $controllerMode, ingressInterface: $ingressInterface, egressInterface: $egressInterface) {  code  success  message  __typename  } } "}'
    fi
fi


#DNS filter
RES=$(curl -X POST http://127.0.0.1:8765/graphql -H "Content-Type:application/json" --max-time 600 -d '{ "query" : "query {  network {  getDNSConfig { configStatus, domainName }  __typename  } }"}' | jq '.')
if [[ "${RES}" =~ "ERROR" ]]; then
	echo -e "\nFailed in retrieving DNS configuration, Cannot proceed further\n";
else
    DNS_DOMAINNAME=$(echo ${RES} | jq -r '.data.network.getDNSConfig.domainName' 2>/dev/null)
    #DNS_CONFIGURED=$(echo ${RES} | jq -r '.data.network.getDNSConfig.configStatus' 2>/dev/null)
	if [ -z "${DNS_DOMAINNAME}" ] || [[ -n ${DNS_DOMAINNAME} && ${DNS_DOMAINNAME} != "localserver.com" ]]; then
		curl -X POST http://127.0.0.1:8765/graphql -H "Content-Type:application/json" --max-time 600 -d '{"variables":{"domain":"'${DNS_DOMAINNAME}'"}, "query":"mutation clearDNSConfig($domain: String!) {  clearDNSConfig(domain: $domain) {  code  success  message  __typename  } } "}'

        curl -X POST http://127.0.0.1:8765/graphql -H "Content-Type:application/json" --max-time 600 -d '{"variables":{"dnsConfig":{"domainName":"localserver.com","inputIface":["'${DCLAN_INTERFACE}'","'${TUN00}'"],"configStatus":true,"isTLS":true,"dnsSEC":true}}, "query":"mutation addDNS($dnsConfig: addDNSServerConfigInput!) {  addDNS(config: $dnsConfig) {  code  message  success  __typename  } } "}'

        curl -X POST http://127.0.0.1:8765/graphql -H "Content-Type:application/json" --max-time 600 -d '{"variables":{"tlsStatus":true}, "query":"mutation enableDisableTLSForward($tlsStatus: Boolean!) {  enableDisableTLSForward(tlsStatus: $tlsStatus) {  code  success  message  __typename  } } "}'

        ##DNS (addAccessControl for LAN01)
        curl -X POST http://127.0.0.1:8765/graphql -H "Content-Type:application/json" --max-time 600 -d '{"variables":{"AccessControl":[{"subnet":"'${DCLAN_DNS_AC}'","action":"allow","description":"'${DCLAN_INTERFACE}' subnet"}]}, "query":"mutation addAccessControl($AccessControl: [AccessControlInput!]!) {  addAccessControl(data: $AccessControl) {  code  success  message  __typename  } } "}'

        ##DNS (addAccessControl for Tunnel00)
        curl -X POST http://127.0.0.1:8765/graphql -H "Content-Type:application/json" --max-time 600 -d '{"variables":{"AccessControl":[{"subnet":"'${TUN00_DNS_AC}'","action":"allow","description":"Tunnel00 subnet"}]}, "query":"mutation addAccessControl($AccessControl: [AccessControlInput!]!) {  addAccessControl(data: $AccessControl) {  code  success  message  __typename  } } "}'

        ##DNS (Forward Zone to DC)
        curl -X POST http://127.0.0.1:8765/graphql -H "Content-Type:application/json" --max-time 600 -d '{"variables":{"ForwardZone":[{"description":"Quad9","forwardHost":"dns.quad9.net","forwardAddr":"9.9.9.9","forwardFirst":false,"forwardTLSUpstream":true,"configStatus":true}]}, "query":"mutation addForwardZoneData($ForwardZone: [ForwardZoneInfoInput!]!) {  addForwardZoneData(data: $ForwardZone) {  code  success  message  __typename  } } "}'

        curl -X POST http://127.0.0.1:8765/graphql -H "Content-Type:application/json" --max-time 600 -d '{"variables":{"ForwardZone":[{"description":"CloudFlare","forwardHost":"cloudflare-dns.com","forwardAddr":"1.1.1.1","forwardFirst":false,"forwardTLSUpstream":true,"configStatus":true}]}, "query":"mutation addForwardZoneData($ForwardZone: [ForwardZoneInfoInput!]!) {  addForwardZoneData(data: $ForwardZone) {  code  success  message  __typename  } } "}'

        ##FILTER
        RES=$(curl -X POST http://127.0.0.1:8765/graphql -H "Content-Type:application/json" --max-time 600 -d '{ "query" : "query {  network {  getDNSFilterConfig { configStatus filterPending }  __typename  } }"}' | jq '.')
        if [[ "${RES}" =~ "ERROR" ]]; then
            echo -e "\nFailed in retrieving DNS Fitler configuration, Cannot proceed further\n";
        else
            DNS_FILTER_CONFIGURED=$(echo ${RES} | jq -r '.data.network.getDNSFilterConfig.configStatus' 2>/dev/null)
            if [ ${DNS_FILTER_CONFIGURED} == "false" ]; then
                ###set repo
                curl -X POST http://127.0.0.1:8765/graphql -H "Content-Type:application/json" --max-time 600 -d '{"variables":{"config":{"type":"refuse","urlPath":"'${DNS_FILTER_REPO}'","updateHour":-1,"configStatus":true,"defaultFilter":false}}, "query":"mutation saveDNSFilterConfig($config: DNSFilterConfigInput!) {  saveDNSFilterConfig(config: $config) {  code  message  success  __typename  } } "}'

                FILTER_PENDING=$(echo ${RES} | jq -r '.data.network.getDNSFilterConfig.filterPending' 2>/dev/null)
                while [ ${FILTER_PENDING} -eq 1 ]
                do
                    sleep 10
                    RES=$(curl -X POST http://127.0.0.1:8765/graphql -H "Content-Type:application/json" --max-time 600 -d '{ "query" : "query {  network {  getDNSFilterConfig { configStatus filterPending }  __typename  } }"}' | jq '.')
                    if [[ "${RES}" =~ "ERROR" ]]; then
                        echo -e "\nFailed in retrieving DNS Filter configuration, Cannot proceed further\n";
                        break
                    else
                        FILTER_PENDING=$(echo ${RES} | jq -r '.data.network.getDNSFilterConfig.filterPending' 2>/dev/null)
                    fi
                done

                if [ ${FILTER_PENDING} -eq 0 ]; then
                    ###enable DNS filter from Steven Black and Adguard
                    curl -X POST http://127.0.0.1:8765/graphql -H "Content-Type:application/json" --max-time 600 -d '{"variables":{"ids":[3,4]}, "query":"mutation enableDNSFilterSource($ids: [Int!]!) {  enableDNSFilterSource(ids: $ids) {  code  success  message  __typename  } } "}'
                fi
            fi
        fi
	fi
fi

