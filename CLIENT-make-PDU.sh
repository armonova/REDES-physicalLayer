#!/bin/bash

VERSION="0100"
IHL="0101"
TOS="00000010"
LENGTH="func"

ID="0000000000000000"
FLAGS="000"
OFFSET="0000000000000"

TTL="00100000"
PROTOCOL="00000110"
CHECKSUM="0000000000000000"

SOURCEIP=$1
DESTINIP=$2

s1="$(cut -d'.' -f1 <<<$SOURCEIP)"
s2="$(cut -d'.' -f2 <<<$SOURCEIP)"
s3="$(cut -d'.' -f3 <<<$SOURCEIP)"
s4="$(cut -d'.' -f4 <<<$SOURCEIP)"

d1="$(cut -d'.' -f1 <<<$DESTINIP)"
d2="$(cut -d'.' -f2 <<<$DESTINIP)"
d3="$(cut -d'.' -f3 <<<$DESTINIP)"
d4="$(cut -d'.' -f4 <<<$DESTINIP)"

s1=`echo "obase=2;$s1" | bc`
s2=`echo "obase=2;$s2" | bc`
s3=`echo "obase=2;$s3" | bc`
s4=`echo "obase=2;$s4" | bc`

d1=`echo "obase=2;$d1" | bc`
d2=`echo "obase=2;$d2" | bc`
d3=`echo "obase=2;$d3" | bc`
d4=`echo "obase=2;$d4" | bc`

s1=$(printf "%08d" $s1)
s2=$(printf "%08d" $s2)
s3=$(printf "%08d" $s3)
s4=$(printf "%08d" $s4)

d1=$(printf "%08d" $d1)
d2=$(printf "%08d" $d2)
d3=$(printf "%08d" $d3)
d4=$(printf "%08d" $d4)

SOURCEIP=$s1$s2$s3$s4
DESTINIP=$d1$d2$d3$d4

DATA=`cat CLIENT2-CLIENT1-pacote.txt`

DATA=`echo $DATA | perl -lpe '$_=unpack"B*"'`

LENGTH=$((${#DATA} + 5*32))
LENGTH=`echo "obase=2;$LENGTH" | bc`
LENGTH=$(printf "%016d" $LENGTH)

echo PDU:

echo $VERSION $IHL $TOS $LENGTH
echo $ID $FLAGS $OFFSET
echo $TTL $PROTOCOL $CHECKSUM
echo $SOURCEIP
echo $DESTINIP
echo $DATA

echo $VERSION$IHL$TOS$LENGTH$ID$FLAGS$OFFSET$TTL$PROTOCOL$CHECKSUM$SOURCEIP$DESTINIP$DATA > CLIENT1-INTERNET1-quadro.txt
