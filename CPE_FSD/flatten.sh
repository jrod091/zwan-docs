#!/bin/bash
ECDOC=""
RESPATH=""
#for i  in `ls  * | grep .md | egrep -iv 'curl|GRAPHQL|API|zwan-doc'`
for i  in `cat FileList.txt`
do
    ABSPATH=`find "$PWD" -name ${i}`
    ECDOC="${ECDOC} ${ABSPATH}"
done;
#RESPATH=":/root/zwan-doc/"
#for i  in `ls -d */`
for i  in `cat DirList.txt`
do
    RESPATH=${RESPATH}:${i}
done

#RESPATH=":AnIntro/:SSHAccessControl/:Monitoring/:Syslog/:DebugDump/:Utilities/:NTP/:Onboarding/:VLAN/:Bond/:Bridges/:DHCPServer/:Gateway/:NAT/:OSPF/:BGP/:Routemaps/:Filtering/:Multicast/:IPSEC/:SSLVPN/:FlowClassification/:LoadBalancer/:Twamp/:TwampScheduler/:FlowOptimizer/:QoS/:Firewall/:Webfilter/:x509Certificates/"
echo $RESPATH

pandoc ${ECDOC} -o ./FSD.html --extract-media=. --resource-path=${RESPATH}
pandoc ${ECDOC} -o ./FSD.pdf -t html  --extract-media=. --resource-path=${RESPATH}

mkdir sdwandoc
mv *.png sdwandoc
mv *.jpg sdwandoc
mv FSD* sdwandoc

