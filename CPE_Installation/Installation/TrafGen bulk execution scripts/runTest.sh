#!/bin/bash

if [ $# -eq 1 ]; then
    COUNT=$1
else
    COUNT=100
fi

((MAX=2000+$COUNT))

echo "MAX :$MAX"

for i in $(seq 2001 $MAX)
do

#    trafgen --dev enp2s0 --conf confFiles/imixtest2_$i.cfg -P 2 & 

#    trafgen --dev enp2s0 --conf confFiles/imixtest3_$i.cfg -P 2 & 

#    trafgen --dev enp2s0 --conf confFiles/imixtest4_$i.cfg -P 2 & 

     trafgen --dev enp2s0 --conf confFiles/imix64byte$i.cfg -P 2 & 

done



