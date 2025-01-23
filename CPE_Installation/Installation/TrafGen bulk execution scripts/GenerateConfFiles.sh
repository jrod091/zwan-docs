#!/bin/bash


# ====== Pre-rquisite =========================================
# 1. sudo apt install netsniff-ng
# 2. sudo apt install tcpreplay
# 3. PCAP file: imixtest2_.pcap
#
#==============================================================

if [ $# -eq 1 ]; then
    COUNT=$1
else
    COUNT=100
fi

((MAX=2000+$COUNT))

echo "MAX :$MAX"

mkdir -p confFiles
mkdir -p pcapFiles
rm -f confFiles/*
rm -f pcapFiles/*

cp imixtest2_.pcap  imixtest2_2000.pcap

for i in $(seq 2001 $MAX)
do
    tcprewrite --infile=imixtest2_.pcap --outfile=pcapFiles/imixtest2_$i.pcap --portmap=2000:$i --fixcsum
    sleep 1
    netsniff-ng --in pcapFiles/imixtest2_$i.pcap --out confFiles/imixtest2_$i.cfg 1>/dev/null 
done

