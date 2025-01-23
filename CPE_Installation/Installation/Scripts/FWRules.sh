
#!/bin/bash

###############################################################################################
#                                                                                             #
#   Script to Create / Delete FW Rules.                                                       #
#   By default it set to Create /Delete 10000 Rules.                                          #
#   If the user pass the Number of Rules to be created/Delete, it will use that value.        #
#                                                                                             #
#   - Default Operation: Create Rules                                                         # 
#   - Default Number of Rules : 10000                                                         #
#   - Operation: Flush option is to cleanup the rules quickly. It saves 2-3 hours time        #
#                                                                                             #
#   Usage:                                                                                    #
#       bash FWRules.sh [Number-of-Rules] [Create/Delete]                                     #
#                                                                                             #
#       bash FWRules.sh                                                                       #
#       bash FWRules.sh <Number-of-Rules>                                                     #
#       bash FWRules.sh 10 [Create]                                                           #
#       bash FWRules.sh 10 Delete                                                             #
#                                                                                             #
#  - Check the Rules in IPTABLES: iptables -L ZWAN_FORWARD --line-number                      #
#                                                                                             #
###############################################################################################



LOGFILE=/dev/null
#LOGFILE=./TestFWRules.log

MAX_RULES=10000
if [ $# -eq 1 ]; then
    MAX_RULES=$1
fi

OPERATION="Create"
if [ $# -eq 2 ]; then
    MAX_RULES=$1
    OPERATION=$2
fi

case "${OPERATION}" in

  "Create")
        echo -e "\n`date`: Adding ${MAX_RULES} FW Rules ...\n"
        {
        echo -e "\n`date`: Adding ${MAX_RULES} FW Rules ...\n"
        i=1
        while [ $i -le ${MAX_RULES} ]
        do
            curl -X POST http://127.0.0.1:8765/graphql -H "Content-Type: application/json" -d '{"operationName": "addFCRule","variables": {"fcRule": {"chain": "ZWAN_FORWARD","seq": '$i',"configuredState": "Enabled","comment": "Sample rule for iperf3 throughput benchmarking","fcTarget": {"target": "ACCEPT"},"fcProtocol": {"protocol": 17,"notProtocol": false,"tcp": null,"udp": null,"icmp": null},"fcConnectionState": {"new": false,"established": false,"related": false,"invalid": false,"untracked": false,"notConnectionState": false},"fcDpi": {"nDPI": "","notNDPI": false},"fcPacketHeader": {"inputIfc": null,"notInputIfc": false,"outputIfc": null,"notOutputIfc": false,"sourceIP": null,"sourceIPSet": null,"notSourceIP": false,"destIP": null,"destIPSet": null,"notDestIP": false,"dscp": null,"fragments": false,"notFragments": false,"packetMinLen": null,"packetMaxLen": null,"notLen": false,"sourceMAC": null,"notSourceMAC": false},"fcTime": {"fromHH": null,"fromMM": null,"toHH": null,"toMM": null,"sun": false,"mon": false,"tue": false,"wed": false,"thu": false,"fri": false,"sat": false},"fcConnectionLimit": {"parallel": null,"parallelMoreLess": null,"traffic": null,"trafficMoreLess": null,"trafficUnit": null},"fcLog": {"logLimit": null,"logLimitSuffixDuration": null,"logBurst": null,"logEnabled": false}}},"query": "mutation addFCRule($fcRule: FCRuleInput!) {\n addFCRule(fcRule: $fcRule) {\n code\n success\n message\n __typename\n }\n}\n"}' #&> ${LOGFILE}
            #sleep 1
            ((i=i+1))
        done
        
        #Add ACCEPT rule for ESTABLISHED state 
        curl -X POST http://127.0.0.1:8765/graphql -H "Content-Type: application/json" -d '{"operationName": "addFCRule","variables": {"fcRule": {"chain": "ZWAN_FORWARD","seq": 1,"configuredState": "Enabled","comment": "Sample rule for iperf3 throughput benchmarking","fcTarget": {"target": "ACCEPT"},"fcProtocol": {"protocol": 6,"notProtocol": false,"tcp": null,"udp": null,"icmp": null},"fcConnectionState": {"new": false,"established": true,"related": false,"invalid": false,"untracked": false,"notConnectionState": false},"fcDpi": {"nDPI": "","notNDPI": false},"fcPacketHeader": {"inputIfc": null,"notInputIfc": false,"outputIfc": null,"notOutputIfc": false,"sourceIP": null,"sourceIPSet": null,"notSourceIP": false,"destIP": null,"destIPSet": null,"notDestIP": false,"dscp": null,"fragments": false,"notFragments": false,"packetMinLen": null,"packetMaxLen": null,"notLen": false,"sourceMAC": null,"notSourceMAC": false},"fcTime": {"fromHH": null,"fromMM": null,"toHH": null,"toMM": null,"sun": false,"mon": false,"tue": false,"wed": false,"thu": false,"fri": false,"sat": false},"fcConnectionLimit": {"parallel": null,"parallelMoreLess": null,"traffic": null,"trafficMoreLess": null,"trafficUnit": null},"fcLog": {"logLimit": null,"logLimitSuffixDuration": null,"logBurst": null,"logEnabled": false}}},"query": "mutation addFCRule($fcRule: FCRuleInput!) {\n addFCRule(fcRule: $fcRule) {\n code\n success\n message\n __typename\n }\n}\n"}' #&> ${LOGFILE}
        echo -e "\n`date`: Completed adding ${MAX_RULES} FW Rules ...\n\n"
        } &>> ${LOGFILE}
        echo -e "\n`date`: Completed adding ${MAX_RULES} FW Rules ...\n\n"
        ;;

  "Delete")
        echo -e "\n`date`: Deleting ${MAX_RULES} FW Rules ...Starting from Seq ${MAX_RULES} to 1...\n"
        {
        echo -e "\n`date`: Deleting ${MAX_RULES} FW Rules ...Starting from Seq ${MAX_RULES} to 1...\n"
        i=${MAX_RULES}
        while [ $i -ge 1 ]
        do
            curl -v -X POST http://127.0.0.1:8765/graphql -H "Content-Type: application/json" -d '{ "query" : "mutation { deleteFCRule(chain: \"ZWAN_FORWARD\", seq: '$i'){code, message, success } }" }' #&>${LOGFILE}

            #sleep 1
            ((i=i-1))
        done
        echo -e "\n`date`: Completed deleting ${MAX_RULES} FW Rules ...Starting from Seq ${MAX_RULES}  to 1...\n\n"
        } &>> ${LOGFILE}
        echo -e "\n`date`: Completed deleting ${MAX_RULES} FW Rules ...Starting from Seq ${MAX_RULES}  to 1...\n\n"
        ;;

  "Flush")
        echo -e "\n`date`: Clearing the FW rules Database ...\n"
        {
        #Cleanup FC Rules in DB
        for TBL in fc_chain_rule_connection_limit_info fc_chain_rule_ndpi_info fc_chain_rule_protocol_icmp_info fc_chain_rule_connection_state_info fc_chain_rule_optimizer_bandwidth_info fc_chain_rule_protocol_info fc_chain_rule_info fc_chain_rule_optimizer_cost_info fc_chain_rule_protocol_tcp_info fc_chain_rule_ipset_info fc_chain_rule_optimizer_info fc_chain_rule_protocol_udp_info fc_chain_rule_l7_info fc_chain_rule_optimizer_path_affinity_info fc_chain_rule_target_info fc_chain_rule_log_info fc_chain_rule_optimizer_performance_info fc_chain_rule_time_info fc_chain_rule_nb_target_info fc_chain_rule_packet_header_info
        do
            echo "TBL: $TBL"
            #sqlite3 /var/register/system/zwan.db "SELECT * FROM $TBL;"
            #read -p "Press Enter "
            sqlite3 /var/register/system/zwan.db "DELETE FROM $TBL;"
            sleep 1
        done

        # Flsuh the iptables rules in ZWAN_FORWARD chain
        iptables -F ZWAN_FORWARD
        echo -e "\n`date`: Completed clearing the FW rules Database and Flushing the rules in iptables ZWAN_FORWARD chain .....\n\n"
        } &>> ${LOGFILE}
        echo -e "\n`date`: Completed clearing the FW rules Database and Flushing the rules in iptbales ZWAN_FORWARD chain ....\n\n"
        
        # Reboot
        echo -e "\n\n ***** Reboot the system  before doing any other Test .....******* \n\n"
        ;;
  *)
    echo -e "\nERROR: Invalid option ..."
    echo -e "\nUsage:\n\tbash $0 [<Num-of-Rules>] [<Create/Delete>]\n\n"
    ;;

esac

