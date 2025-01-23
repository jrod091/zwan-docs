#!/bin/bash
# shellcheck source=/dev/null
# shellcheck disable=SC2016
#vEC configuration

#IMPORTANT NOTE: Create one Client Certicate using Director UI manually#

##data needed to reach DC and to configure SaaS
export DC_TUNNEL_PUBLICIPs="4.21.30.249/32"
export DC_TUNNEL_WAN00_VIA_GW="192.168.1.254"

#TunnelType (1: IPSEC / 0: SSLVPN)
IPSEC=1

##data needed to create SSLVPN/IPSEC
export WAN00_localIP="192.168.1.65"				
export TUN00_localIP="10.150.0.69"
export TUN00_remoteIP="10.150.0.1"

export TUN00_DC_TUNNEL_PUBLICIP="4.21.30.249"
export TUN00_PORT="10001"
export TUN00_LEFT_SUBNET="10.150.1.2/32,192.168.34.0/24"


##DNS Access Control
export LAN_INTERFACE="LAN01"
export LAN01_DNS_AC="172.16.168.69/24"
export TUN00_DNS_AC="10.150.0.0/24"

##QoS: Provide bandwidth in mbps
export TUN00_BW_GUA=75
export TUN00_BW_MAX=100

export WAN00_BW_GUA=75
export WAN00_BW_MAX=100


#"'${abc}'"
#check for valid certificate
RES=$(curl -X POST http://127.0.0.1:8765/graphql -H "Content-Type:application/json" --max-time 600 -d '{ "query" : "query {  security {  certificates(type:HOST, id:\"00\") { subjectText }  __typename  } }"}' | jq '.')
if [[ "${RES}" =~ "ERROR" ]]; then
	echo -e "\nFailed in retrieving Certificate configuration, Cannot proceed further\n";
	exit 1
else
	LEFT00_CERTID="$(echo ${RES} | jq -r '.data.security.certificates[0].subjectText' 2>/dev/null)"
fi

if [ -z "${LEFT00_CERTID}" ] || [ "${LEFT00_CERTID}" = "null" ]; then
	echo -e "\nFailed to retrieve Certificate configuration, Cannot proceed further\n";
	exit 1
fi

echo ${LEFT00_CERTID}  

if [ ${IPSEC} == 1 ]; then
	export TUN00=IPSEC00
else
	export TUN00=VPN00
fi


#Enable WAN Interfaces
curl -X POST http://127.0.0.1:8765/graphql -H "Content-Type:application/json" --max-time 600 -d '{"variables":{"name":"WAN00","status":true}, "query":"mutation setInterfaceState($name: String!, $status: Boolean!) {  setInterfaceState(name: $name, status: $status) {  code  success  message  interface {  configuredStatus  __typename  }  __typename  } } "}'

#Create NB to REACH DC TUNNEL
##via WAN00
curl -X POST http://127.0.0.1:8765/graphql -H "Content-Type:application/json" --max-time 600 -d '{"variables":{"description":"Tunnel via WAN00","destIP":"'${DC_TUNNEL_WAN00_VIA_GW}'","localInterface":"WAN00","configuredStatus":"UP","weight":1,"timeoutCoefficient":1,"type":"BRANCH","branchName":"DC_TUNNEL_ALL","branchLan":"'${DC_TUNNEL_PUBLICIPs}'"}, "query":"mutation addNBGateway($description: String!, $destIP: IPv4!, $localInterface: String!, $configuredStatus: NBGatewayStatus!, $weight: Int!, $timeoutCoefficient: Int!, $type: NBGatewayType!, $branchName: String, $branchLan: String) {  addNBGateway(description: $description, destIP: $destIP, localInterface: $localInterface, configuredStatus: $configuredStatus, weight: $weight, timeoutCoefficient: $timeoutCoefficient, type: $type, branchName: $branchName, branchLan: $branchLan) {  code  success  message  __typename  } } "}'

##saveNetBalancerConfig
curl -X POST http://127.0.0.1:8765/graphql -H "Content-Type:application/json" --max-time 600 -d '{"variables":{"type":"BRANCH","branchName":"DC_TUNNEL_ALL","configuredStatus":"Enabled","mode":"LBFO","packetLB":false,"icmpCheck":"Enabled","probesUP":2,"probesDOWN":3,"pauseInterval":2,"icmpReplyTimeout":2,"pppdRestart":false,"foMonitorEnabledIP1":"Enabled","foMonitorIP1":"8.8.8.8","foMonitorEnabledIP2":"Disabled","foMonitorIP2":null,"foMonitorEnabledIP3":"Disabled","foMonitorIP3":null}, "query":"mutation saveNetBalancerConfig($type: NBGatewayType!, $branchName: String, $configuredStatus: EnabledDisabled!, $mode: NBMode!, $packetLB: Boolean!, $icmpCheck: EnabledDisabled!, $probesUP: Int, $probesDOWN: Int, $pauseInterval: Int, $icmpReplyTimeout: Int, $pppdRestart: Boolean, $foMonitorEnabledIP1: EnabledDisabled!, $foMonitorIP1: IPv4, $foMonitorEnabledIP2: EnabledDisabled!, $foMonitorIP2: IPv4, $foMonitorEnabledIP3: EnabledDisabled!, $foMonitorIP3: IPv4) {  saveNetBalancerConfig(type: $type, branchName: $branchName, configuredStatus: $configuredStatus, mode: $mode, packetLB: $packetLB, icmpCheck: $icmpCheck, probesUP: $probesUP, probesDOWN: $probesDOWN, pauseInterval: $pauseInterval, icmpReplyTimeout: $icmpReplyTimeout, pppdRestart: $pppdRestart, foMonitorEnabledIP1: $foMonitorEnabledIP1, foMonitorIP1: $foMonitorIP1, foMonitorEnabledIP2: $foMonitorEnabledIP2, foMonitorIP2: $foMonitorIP2, foMonitorEnabledIP3: $foMonitorEnabledIP3, foMonitorIP3: $foMonitorIP3) {  code  success  message  __typename  } } "}'

#SaaS Breakout
#via WAN00
curl -X POST http://127.0.0.1:8765/graphql -H "Content-Type:application/json" --max-time 600 -d '{"variables":{"description":"SaaS via WAN00","destIP":"'${DC_TUNNEL_WAN00_VIA_GW}'","localInterface":"WAN00","configuredStatus":"UP","weight":1,"timeoutCoefficient":1,"type":"SAAS","branchName":"","branchLan":""}, "query":"mutation addNBGateway($description: String!, $destIP: IPv4!, $localInterface: String!, $configuredStatus: NBGatewayStatus!, $weight: Int!, $timeoutCoefficient: Int!, $type: NBGatewayType!, $branchName: String, $branchLan: String) {  addNBGateway(description: $description, destIP: $destIP, localInterface: $localInterface, configuredStatus: $configuredStatus, weight: $weight, timeoutCoefficient: $timeoutCoefficient, type: $type, branchName: $branchName, branchLan: $branchLan) {  code  success  message  __typename  } } "}'

curl -X POST http://127.0.0.1:8765/graphql -H "Content-Type:application/json" --max-time 600 -d '{"variables":{"type":"SAAS","branchName":null,"configuredStatus":"Enabled","mode":"LBFO","packetLB":false,"icmpCheck":"Enabled","probesUP":2,"probesDOWN":3,"pauseInterval":2,"icmpReplyTimeout":2,"pppdRestart":false,"foMonitorEnabledIP1":"Enabled","foMonitorIP1":"8.8.8.8","foMonitorEnabledIP2":"Disabled","foMonitorIP2":null,"foMonitorEnabledIP3":"Disabled","foMonitorIP3":null}, "query":"mutation saveNetBalancerConfig($type: NBGatewayType!, $branchName: String, $configuredStatus: EnabledDisabled!, $mode: NBMode!, $packetLB: Boolean!, $icmpCheck: EnabledDisabled!, $probesUP: Int, $probesDOWN: Int, $pauseInterval: Int, $icmpReplyTimeout: Int, $pppdRestart: Boolean, $foMonitorEnabledIP1: EnabledDisabled!, $foMonitorIP1: IPv4, $foMonitorEnabledIP2: EnabledDisabled!, $foMonitorIP2: IPv4, $foMonitorEnabledIP3: EnabledDisabled!, $foMonitorIP3: IPv4) {  saveNetBalancerConfig(type: $type, branchName: $branchName, configuredStatus: $configuredStatus, mode: $mode, packetLB: $packetLB, icmpCheck: $icmpCheck, probesUP: $probesUP, probesDOWN: $probesDOWN, pauseInterval: $pauseInterval, icmpReplyTimeout: $icmpReplyTimeout, pppdRestart: $pppdRestart, foMonitorEnabledIP1: $foMonitorEnabledIP1, foMonitorIP1: $foMonitorIP1, foMonitorEnabledIP2: $foMonitorEnabledIP2, foMonitorIP2: $foMonitorIP2, foMonitorEnabledIP3: $foMonitorEnabledIP3, foMonitorIP3: $foMonitorIP3) {  code  success  message  __typename  } } "}'

##SaaS APPS (ndpi) via SaaS Gateway
curl -X POST http://127.0.0.1:8765/graphql -H "Content-Type:application/json" --max-time 600 -d '{"variables":{"saasApps":["skype_teams","teams","salesforce","amazonaws","azure","googlecloud"]}, "query":"mutation setSAASApps($saasApps: [String!]!) {  setSAASApps(saasApps: $saasApps) {  code  success  message  __typename  } } "}'

##Steer SaaS (azure) on WAN00 (IB Gateway 0002)
curl -X POST http://127.0.0.1:8765/graphql -H "Content-Type:application/json" --max-time 600 -d '{"variables":{"fcRule":{"chain":"NetBalancer","seq":1,"configuredState":"Enabled","comment":"Productivity Cate via Tunnel00","fcTarget":{"type":"INTERNET","target":"0002","isAutoFlowControl":false},"fcConnectionState":{"new":false,"established":false,"related":false,"invalid":false,"untracked":false,"notConnectionState":false},"fcDpi":{"nDPI":"azure","notNDPI":false},"fcIpSet":{"ipSet":"","notIpSet":false},"fcPacketHeader":{"inputIfc":null,"notInputIfc":false,"outputIfc":null,"notOutputIfc":false,"sourceIP":null,"sourceIPSet":null,"notSourceIP":false,"destIP":null,"destIPSet":null,"notDestIP":false,"dscp":null,"fragments":false,"notFragments":false,"packetMinLen":null,"packetMaxLen":null,"notLen":false,"sourceMAC":null,"notSourceMAC":false},"fcTime":{"fromHH":null,"fromMM":null,"toHH":null,"toMM":null,"sun":false,"mon":false,"tue":false,"wed":false,"thu":false,"fri":false,"sat":false},"fcConnectionLimit":{"parallel":null,"parallelMoreLess":null,"traffic":null,"trafficMoreLess":null,"trafficUnit":null},"fcLog":{"logLimit":null,"logLimitSuffixDuration":null,"logBurst":null,"logEnabled":false}}}, "query":"mutation addFCRule($fcRule: FCRuleInput!) {  addFCRule(fcRule: $fcRule) {  code  success  message  __typename  } } "}'


#Create Tunnel(s)

if [ ${IPSEC} == 1 ]; then

	##create IPSEC00 (with gateway 0001 and cert 00) and add IPv4
	curl -X POST http://127.0.0.1:8765/graphql -H "Content-Type:application/json" --max-time 600 -d '{"variables":{"description":"to DC via WAN00","tunnelUUID":"IPSEC00viaWAN00","left":"'${WAN00_localIP}'","right":"'${TUN00_DC_TUNNEL_PUBLICIP}'","gateway":"0001","leftSubnet":"'${TUN00_LEFT_SUBNET}'","rightSubnet":"0.0.0.0/0","authType":"X509","type":"ESP","encrptionAlg":"aes256gcm16","integrityAlg":"sha512","dhGroup":"modp4096","lifeTime":"1h","ikeVersion":"ikev2","ikeEncrptionAlg":"aes256gcm16","ikeIntegrityAlg":"sha256","ikeDHGroup":"modp3072","ikeLifetime":"3h","dpdDelay":"30s","dpdTimeout":"150s","dpdAction":"restart","compress":"no","forceUdpEncaps":"yes","leftCert":"00","leftCertId":"'"${LEFT00_CERTID}"'","rightCertId":""}, "query":"mutation createIPsec($description: String!, $tunnelUUID: String!, $type: TunnelType!, $encrptionAlg: String!, $integrityAlg: String!, $dhGroup: String!, $leftSubnet: String, $rightSubnet: String, $lifeTime: String!, $ikeVersion: IKEversion!, $ikeMode: IKEmode, $ikeEncrptionAlg: String!, $ikeIntegrityAlg: String!, $ikeDHGroup: String!, $ikeLifetime: String!, $dpdDelay: String!, $dpdTimeout: String!, $dpdAction: DPDAction!, $left: String!, $right: String!, $authType: AuthenticationType!, $secrets: String, $leftCert: String, $leftCertId: String, $rightCertId: String, $compress: SetValue, $forceUdpEncaps: SetValue, $gateway: String!) {  createIPsec(description: $description, tunnelUUID: $tunnelUUID, type: $type, encrptionAlg: $encrptionAlg, integrityAlg: $integrityAlg, dhGroup: $dhGroup, leftSubnet: $leftSubnet, rightSubnet: $rightSubnet, lifeTime: $lifeTime, ikeVersion: $ikeVersion, ikeMode: $ikeMode, ikeEncrptionAlg: $ikeEncrptionAlg, ikeIntegrityAlg: $ikeIntegrityAlg, ikeDHGroup: $ikeDHGroup, ikeLifetime: $ikeLifetime, dpdDelay: $dpdDelay, dpdTimeout: $dpdTimeout, dpdAction: $dpdAction, left: $left, right: $right, authType: $authType, secrets: $secrets, leftCert: $leftCert, leftCertId: $leftCertId, rightCertId: $rightCertId, compress: $compress, forceUdpEncaps: $forceUdpEncaps, gateway: $gateway) {  code  success  message  ipsec {  description  __typename  }  __typename  } } "}'

	curl -X POST http://127.0.0.1:8765/graphql -H "Content-Type:application/json" --max-time 600 -d '{"variables":{"name":"IPSEC00","ip":{"ipv4":{"address":"'${TUN00_localIP}'","netmask":"255.255.255.0"}},"twampResponder":false}, "query":"mutation addIP($name: String!, $ip: IPTypeInfoInput!, $interfaceType: InterfaceType, $gateway: String, $dns: [String], $tag: Int, $twampResponder: Boolean) {  addIP(name: $name, ip: $ip, interfaceType: $interfaceType, gateway: $gateway, dns: $dns, tag: $tag, twampResponder: $twampResponder) {  success  code  message  __typename  } } "}'

else 

	##create Tunnel00 (with gateway 0001 and cert 00) and add IPv4
	curl -X POST http://127.0.0.1:8765/graphql -H "Content-Type:application/json" --max-time 600 -d '{"variables":{"description":"to DC via WAN00","tunnelUUID":"SSLVPNviaWAN00","localIP":"'${WAN00_localIP}'","remoteIP":"'${TUN00_DC_TUNNEL_PUBLICIP}'","port":'${TUN00_PORT}',"proto":"UDP","role":"Client","remoteCN":"","compression":true,"encryption":true,"parameters":"","authType":"X509","gateway":"0001","certId":"00"}, "query":"mutation createOpenVPN($description: String!, $tunnelUUID: String!, $localIP: String!, $remoteIP: String, $port: Int!, $proto: ProtoType!, $role: RoleType!, $remoteCN: String, $compression: Boolean!, $encryption: Boolean!, $parameters: String, $authType: AuthenticationType!, $psk: String, $gateway: String!, $certId: String) {  createOpenVPN(description: $description, tunnelUUID: $tunnelUUID, localIP: $localIP, remoteIP: $remoteIP, port: $port, proto: $proto, role: $role, remoteCN: $remoteCN, compression: $compression, encryption: $encryption, parameters: $parameters, authType: $authType, psk: $psk, gateway: $gateway, certId: $certId, certType: Imported) {  code  success  message  openVPN {  name  description  cert {  displayName  __typename  }  __typename  }  __typename  } } "}'

	curl -X POST http://127.0.0.1:8765/graphql -H "Content-Type:application/json" --max-time 600 -d '{"variables":{"name":"'${TUN00}'","ip":{"ipv4":{"address":"'${TUN00_localIP}'","netmask":"255.255.255.0"}},"twampResponder":false}, "query":"mutation addIP($name: String!, $ip: IPTypeInfoInput!, $interfaceType: InterfaceType, $gateway: String, $dns: [String], $tag: Int, $twampResponder: Boolean) {  addIP(name: $name, ip: $ip, interfaceType: $interfaceType, gateway: $gateway, dns: $dns, tag: $tag, twampResponder: $twampResponder) {  success  code  message  __typename  } } "}'

fi


#IB
##via Tunnel00
curl -X POST http://127.0.0.1:8765/graphql -H "Content-Type:application/json" --max-time 600 -d '{"variables":{"description":"IB via Tunnel00","destIP":"'${TUN00_remoteIP}'","localInterface":"'${TUN00}'","configuredStatus":"UP","weight":3,"timeoutCoefficient":1,"type":"INTERNET","branchName":"","branchLan":""}, "query":"mutation addNBGateway($description: String!, $destIP: IPv4!, $localInterface: String!, $configuredStatus: NBGatewayStatus!, $weight: Int!, $timeoutCoefficient: Int!, $type: NBGatewayType!, $branchName: String, $branchLan: String) {  addNBGateway(description: $description, destIP: $destIP, localInterface: $localInterface, configuredStatus: $configuredStatus, weight: $weight, timeoutCoefficient: $timeoutCoefficient, type: $type, branchName: $branchName, branchLan: $branchLan) {  code  success  message  __typename  } } "}'


##saveNetBalancerConfig
curl -X POST http://127.0.0.1:8765/graphql -H "Content-Type:application/json" --max-time 600 -d '{"variables":{"type":"INTERNET","branchName":null,"configuredStatus":"Enabled","mode":"LBFO","packetLB":true,"icmpCheck":"Disabled","probesUP":2,"probesDOWN":3,"pauseInterval":2,"icmpReplyTimeout":2,"pppdRestart":false,"foMonitorEnabledIP1":"Disabled","foMonitorIP1":null,"foMonitorEnabledIP2":"Disabled","foMonitorIP2":null,"foMonitorEnabledIP3":"Disabled","foMonitorIP3":null}, "query":"mutation saveNetBalancerConfig($type: NBGatewayType!, $branchName: String, $configuredStatus: EnabledDisabled!, $mode: NBMode!, $packetLB: Boolean!, $icmpCheck: EnabledDisabled!, $probesUP: Int, $probesDOWN: Int, $pauseInterval: Int, $icmpReplyTimeout: Int, $pppdRestart: Boolean, $foMonitorEnabledIP1: EnabledDisabled!, $foMonitorIP1: IPv4, $foMonitorEnabledIP2: EnabledDisabled!, $foMonitorIP2: IPv4, $foMonitorEnabledIP3: EnabledDisabled!, $foMonitorIP3: IPv4) {  saveNetBalancerConfig(type: $type, branchName: $branchName, configuredStatus: $configuredStatus, mode: $mode, packetLB: $packetLB, icmpCheck: $icmpCheck, probesUP: $probesUP, probesDOWN: $probesDOWN, pauseInterval: $pauseInterval, icmpReplyTimeout: $icmpReplyTimeout, pppdRestart: $pppdRestart, foMonitorEnabledIP1: $foMonitorEnabledIP1, foMonitorIP1: $foMonitorIP1, foMonitorEnabledIP2: $foMonitorEnabledIP2, foMonitorIP2: $foMonitorIP2, foMonitorEnabledIP3: $foMonitorEnabledIP3, foMonitorIP3: $foMonitorIP3) {  code  success  message  __typename  } } "}'


##Steer Productivity Categories on Tunnel 00 (IB Gateway 0003)
curl -X POST http://127.0.0.1:8765/graphql -H "Content-Type:application/json" --max-time 600 -d '{"variables":{"fcRule":{"chain":"NetBalancer","seq":1,"configuredState":"Enabled","comment":"Productivity Cat via Tunnel00","fcTarget":{"type":"INTERNET","target":"0003","isAutoFlowControl":false},"fcConnectionState":{"new":false,"established":false,"related":false,"invalid":false,"untracked":false,"notConnectionState":false},"fcDpi":{"nDPI":"","notNDPI":false},"fcIpSet":{"ipSet":"Productivity","notIpSet":false},"fcPacketHeader":{"inputIfc":null,"notInputIfc":false,"outputIfc":null,"notOutputIfc":false,"sourceIP":null,"sourceIPSet":null,"notSourceIP":false,"destIP":null,"destIPSet":null,"notDestIP":false,"dscp":null,"fragments":false,"notFragments":false,"packetMinLen":null,"packetMaxLen":null,"notLen":false,"sourceMAC":null,"notSourceMAC":false},"fcTime":{"fromHH":null,"fromMM":null,"toHH":null,"toMM":null,"sun":false,"mon":false,"tue":false,"wed":false,"thu":false,"fri":false,"sat":false},"fcConnectionLimit":{"parallel":null,"parallelMoreLess":null,"traffic":null,"trafficMoreLess":null,"trafficUnit":null},"fcLog":{"logLimit":null,"logLimitSuffixDuration":null,"logBurst":null,"logEnabled":false}}}, "query":"mutation addFCRule($fcRule: FCRuleInput!) {  addFCRule(fcRule: $fcRule) {  code  success  message  __typename  } } "}'

#DNS filter
RES=$(curl -X POST http://127.0.0.1:8765/graphql -H "Content-Type:application/json" --max-time 600 -d '{ "query" : "query {  network {  getDNSConfig { configStatus, domainName }  __typename  } }"}' | jq '.')
if [[ "${RES}" =~ "ERROR" ]]; then
	echo -e "\nFailed in retrieving DNS configuration, Cannot proceed further\n";
else
	DNS_DOMAINNAME=$(echo ${RES} | jq -r '.data.network.getDNSConfig.domainName' 2>/dev/null)
    #DNS_CONFIGURED=$(echo ${RES} | jq -r '.data.network.getDNSConfig.configStatus' 2>/dev/null)
	if [ -n "${DNS_DOMAINNAME}" ]; then
		curl -X POST http://127.0.0.1:8765/graphql -H "Content-Type:application/json" --max-time 600 -d '{"variables":{"domain":"'${DNS_DOMAINNAME}'"}, "query":"mutation clearDNSConfig($domain: String!) {  clearDNSConfig(domain: $domain) {  code  success  message  __typename  } } "}'
	fi

	##DNS (LAN01)
	curl -X POST http://127.0.0.1:8765/graphql -H "Content-Type:application/json" --max-time 600 -d '{"variables":{"dnsConfig":{"domainName":"localserver.com","inputIface":["'${LAN_INTERFACE}'"],"configStatus":true,"isTLS":false,"dnsSEC":false}}, "query":"mutation addDNS($dnsConfig: addDNSServerConfigInput!) {  addDNS(config: $dnsConfig) {  code  message  success  __typename  } } "}'
fi

##DNS (addAccessControl for LAN01)
curl -X POST http://127.0.0.1:8765/graphql -H "Content-Type:application/json" --max-time 600 -d '{"variables":{"AccessControl":[{"subnet":"'${LAN01_DNS_AC}'","action":"allow","description":"'${LAN_INTERFACE}' subnet"}]}, "query":"mutation addAccessControl($AccessControl: [AccessControlInput!]!) {  addAccessControl(data: $AccessControl) {  code  success  message  __typename  } } "}'

##DNS (Forward Zone to DC)
curl -X POST http://127.0.0.1:8765/graphql -H "Content-Type:application/json" --max-time 600 -d '{"variables":{"ForwardZone":[{"description":"DC'${TUN00}'","forwardHost":"dc.'${TUN00}'.net","forwardAddr":"'${TUN00_remoteIP}'","forwardFirst":false,"forwardTLSUpstream":false,"configStatus":true}]}, "query":"mutation addForwardZoneData($ForwardZone: [ForwardZoneInfoInput!]!) {  addForwardZoneData(data: $ForwardZone) {  code  success  message  __typename  } } "}'

#DDoS
curl -X POST http://127.0.0.1:8765/graphql -H "Content-Type:application/json" --max-time 600 -d '{"variables":{"interfaceName":"WAN00","enabled":true}, "query":"mutation enableDisableDDOSInterface($interfaceName: String!, $enabled: Boolean!) {  enableDisableDDOSInterface(interfaceName: $interfaceName, enabled: $enabled) {  code  success  message  __typename  } } "}'
curl -X POST http://127.0.0.1:8765/graphql -H "Content-Type:application/json" --max-time 600 -d '{"variables":{"enabled":true}, "query":"mutation enableDisableDDOS($enabled: Boolean!) {  enableDisableDDOS(enabled: $enabled) {  code  success  message  __typename  } } "}'

curl -X POST http://127.0.0.1:8765/graphql -H "Content-Type:application/json" --max-time 600 -d '{"variables":{"ipRange":"10.0.0.0/8"}, "query":"mutation deleteSpoofAddress($ipRange: String!) {  deleteSpoofAddress(ipRange: $ipRange) {  code  message  success  __typename  } } "}'

curl -X POST http://127.0.0.1:8765/graphql -H "Content-Type:application/json" --max-time 600 -d '{"variables":{"ipRange":"192.168.0.0/16"}, "query":"mutation deleteSpoofAddress($ipRange: String!) {  deleteSpoofAddress(ipRange: $ipRange) {  code  message  success  __typename  } } "}'


#QoS
##Productivity class
curl -X POST http://127.0.0.1:8765/graphql -H "Content-Type:application/json" --max-time 600 -d '{"variables":{"classManager":{"cmName":"Productivity","description":"Productivity","priority":"High","dscp":34,"maxBandwidth":200,"maxBandwidthUnit":"MBits_per_sec","guaranteedBandwidth":50,"guaranteedBandwidthUnit":"MBits_per_sec"}}, "query":"mutation createClassManager($classManager: ClassManagerInput!) {  createClassManager(classManager: $classManager) {  code  success  message  __typename  } } "}'

##Cloud class
curl -X POST http://127.0.0.1:8765/graphql -H "Content-Type:application/json" --max-time 600 -d '{"variables":{"classManager":{"cmName":"Cloud","description":"Cloud Services","priority":"High","dscp":10,"maxBandwidth":100,"maxBandwidthUnit":"MBits_per_sec","guaranteedBandwidth":50,"guaranteedBandwidthUnit":"MBits_per_sec"}}, "query":"mutation createClassManager($classManager: ClassManagerInput!) {  createClassManager(classManager: $classManager) {  code  success  message  __typename  } } "}'

##enable class
curl -X POST http://127.0.0.1:8765/graphql -H "Content-Type:application/json" --max-time 600 -d '{"variables":{"cmName":"Productivity","configuredState":"Enabled"}, "query":"mutation enableDisableClassManager($cmName: String!, $configuredState: EnabledDisabled!) {  enableDisableClassManager(cmName: $cmName, configuredState: $configuredState) {  code  success  message  __typename  } } "}'

curl -X POST http://127.0.0.1:8765/graphql -H "Content-Type:application/json" --max-time 600 -d '{"variables":{"cmName":"Cloud","configuredState":"Enabled"}, "query":"mutation enableDisableClassManager($cmName: String!, $configuredState: EnabledDisabled!) {  enableDisableClassManager(cmName: $cmName, configuredState: $configuredState) {  code  success  message  __typename  } } "}'


##Productivity Categories Rule to Productivity class
curl -X POST http://127.0.0.1:8765/graphql -H "Content-Type:application/json" --max-time 600 -d '{"variables":{"fcRule":{"chain":"QoS","seq":1,"configuredState":"Enabled","comment":"Productivity","fcTarget":{"target":"Productivity","forwardType":"ROUTED_AND_BRIDGED"},"fcConnectionState":{"new":false,"established":false,"related":false,"invalid":false,"untracked":false,"notConnectionState":false},"fcDpi":{"nDPI":"","notNDPI":false},"fcIpSet":{"ipSet":"Productivity","notIpSet":false},"fcPacketHeader":{"inputIfc":null,"notInputIfc":false,"outputIfc":null,"notOutputIfc":false,"sourceIP":null,"sourceIPSet":null,"notSourceIP":false,"destIP":null,"destIPSet":null,"notDestIP":false,"dscp":null,"fragments":false,"notFragments":false,"packetMinLen":null,"packetMaxLen":null,"notLen":false,"sourceMAC":null,"notSourceMAC":false},"fcTime":{"fromHH":null,"fromMM":null,"toHH":null,"toMM":null,"sun":false,"mon":false,"tue":false,"wed":false,"thu":false,"fri":false,"sat":false},"fcConnectionLimit":{"parallel":null,"parallelMoreLess":null,"traffic":null,"trafficMoreLess":null,"trafficUnit":null},"fcLog":{"logLimit":null,"logLimitSuffixDuration":null,"logBurst":null,"logEnabled":false}}}, "query":"mutation addFCRule($fcRule: FCRuleInput!) {  addFCRule(fcRule: $fcRule) {  code  success  message  __typename  } } "}'


##Cloud Services ("skype_teams,teams,salesforce,amazonaws,azure,googlecloud")  Rule to Cloud class
curl -X POST http://127.0.0.1:8765/graphql -H "Content-Type:application/json" --max-time 600 -d '{"variables":{"fcRule":{"chain":"QoS","seq":1,"configuredState":"Enabled","comment":"Cloud Services","fcTarget":{"target":"Cloud","forwardType":"ROUTED_AND_BRIDGED"},"fcConnectionState":{"new":false,"established":false,"related":false,"invalid":false,"untracked":false,"notConnectionState":false},"fcDpi":{"nDPI":"skype_teams teams salesforce amazonaws azure googlecloud","notNDPI":false},"fcIpSet":{"ipSet":"","notIpSet":false},"fcPacketHeader":{"inputIfc":null,"notInputIfc":false,"outputIfc":null,"notOutputIfc":false,"sourceIP":null,"sourceIPSet":null,"notSourceIP":false,"destIP":null,"destIPSet":null,"notDestIP":false,"dscp":null,"fragments":false,"notFragments":false,"packetMinLen":null,"packetMaxLen":null,"notLen":false,"sourceMAC":null,"notSourceMAC":false},"fcTime":{"fromHH":null,"fromMM":null,"toHH":null,"toMM":null,"sun":false,"mon":false,"tue":false,"wed":false,"thu":false,"fri":false,"sat":false},"fcConnectionLimit":{"parallel":null,"parallelMoreLess":null,"traffic":null,"trafficMoreLess":null,"trafficUnit":null},"fcLog":{"logLimit":null,"logLimitSuffixDuration":null,"logBurst":null,"logEnabled":false}}}, "query":"mutation addFCRule($fcRule: FCRuleInput!) {  addFCRule(fcRule: $fcRule) {  code  success  message  __typename  } } "}'


##addClassManagerToInterface
curl -X POST http://127.0.0.1:8765/graphql -H "Content-Type:application/json" --max-time 600 -d '{"variables":{"ifcName":"'${TUN00}'","cmName":"Productivity"}, "query":"mutation addClassManagerToInterface($ifcName: String!, $cmName: String!) {  addClassManagerToInterface(ifcName: $ifcName, cmName: $cmName) {  code  success  message  __typename  } } "}'

curl -X POST http://127.0.0.1:8765/graphql -H "Content-Type:application/json" --max-time 600 -d '{"variables":{"ifcName":"WAN00","cmName":"Cloud"}, "query":"mutation addClassManagerToInterface($ifcName: String!, $cmName: String!) {  addClassManagerToInterface(ifcName: $ifcName, cmName: $cmName) {  code  success  message  __typename  } } "}'


##set WAN bandwidth for WAN00 
curl -X POST http://127.0.0.1:8765/graphql -H "Content-Type:application/json" --max-time 600 -d '{"variables":{"qosInterface":{"ifcName":"WAN00","maxBandwidth":'${WAN00_BW_MAX}',"maxBandwidthUnit":"MBits_per_sec","guaranteedBandwidth":'${WAN00_BW_GUA}',"guaranteedBandwidthUnit":"MBits_per_sec"}}, "query":"mutation editQoSBandwidthOfInInterface($qosInterface: QoSInterfaceInput!) {  editQoSBandwidthOfInInterface(qosInterface: $qosInterface) {  code  success  message  __typename  } } "}'

##set WAN bandwidth for Tunnel 00 
curl -X POST http://127.0.0.1:8765/graphql -H "Content-Type:application/json" --max-time 600 -d '{"variables":{"qosInterface":{"ifcName":"'${TUN00}'","maxBandwidth":'${TUN00_BW_MAX}',"maxBandwidthUnit":"MBits_per_sec","guaranteedBandwidth":'${TUN00_BW_GUA}',"guaranteedBandwidthUnit":"MBits_per_sec"}}, "query":"mutation editQoSBandwidthOfInInterface($qosInterface: QoSInterfaceInput!) {  editQoSBandwidthOfInInterface(qosInterface: $qosInterface) {  code  success  message  __typename  } } "}'

curl -X POST http://127.0.0.1:8765/graphql -H "Content-Type:application/json" --max-time 600 -d '{"variables":{"ifcName":"WAN00","configuredState":"Enabled"}, "query":"mutation enableDisableQoSOfInInterface($ifcName: String!, $configuredState: EnabledDisabled!) {  enableDisableQoSOfInInterface(ifcName: $ifcName, configuredState: $configuredState) {  code  success  message  __typename  } } "}'

curl -X POST http://127.0.0.1:8765/graphql -H "Content-Type:application/json" --max-time 600 -d '{"variables":{"ifcName":"'${TUN00}'","configuredState":"Enabled"}, "query":"mutation enableDisableQoSOfInInterface($ifcName: String!, $configuredState: EnabledDisabled!) {  enableDisableQoSOfInInterface(ifcName: $ifcName, configuredState: $configuredState) {  code  success  message  __typename  } } "}'

#activate QoS
curl -X POST http://127.0.0.1:8765/graphql -H "Content-Type:application/json" --max-time 600 -d '{"variables":{}, "query":"mutation activateQoSChangesForCPE($dummy: String) {  activateQoSChangesForCPE(dummy: $dummy) {  code  success  message  __typename  } } "}'

#Blocked Categories
curl -X POST http://127.0.0.1:8765/graphql -H "Content-Type:application/json" --max-time 600 -d '{"variables":{"categories":["Dating","P2P","Adult","MusicalSharing","Chat","Sports","Gaming","Streaming"]}, "query":"mutation updateBlockedCategories($categories: [String!]!) {  updateBlockedCategories(categories: $categories) {  code  success  message  __typename  } } "}'
