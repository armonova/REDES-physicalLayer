#!/bin/bash

QUA=`cat INTERNET-CLIENT1-quadro.txt`

echo QUA:
echo $QUA
echo

VERSION="$(echo $QUA | sed -r 's/^(.{4}).*$/\1/g')"
IHL="$(echo $QUA | sed -r 's/^.{4}(.{4}).*$/\1/g')"
TOS="$(echo $QUA | sed -r 's/^.{8}(.{8}).*$/\1/g')"
LENGTH="$(echo $QUA | sed -r 's/^.{16}(.{16}).*$/\1/g')"

ID="$(echo $QUA | sed -r 's/^.{32}(.{16}).*$/\1/g')"
FLAGS="$(echo $QUA | sed -r 's/^.{48}(.{3}).*$/\1/g')"
OFFSET="$(echo $QUA | sed -r 's/^.{51}(.{13}).*$/\1/g')"

TTL="$(echo $QUA | sed -r 's/^.{64}(.{8}).*$/\1/g')"
PROTOCOL="$(echo $QUA | sed -r 's/^.{72}(.{8}).*$/\1/g')"
CHECKSUM="$(echo $QUA | sed -r 's/^.{80}(.{16}).*$/\1/g')"

SOURCEIP="$(echo $QUA | sed -r 's/^.{96}(.{32}).*$/\1/g')"
DESTINIP="$(echo $QUA | sed -r 's/^.{128}(.{32}).*$/\1/g')"

s1="$(echo $SOURCEIP | sed -r 's/^(.{8}).*$/\1/g')"
s2="$(echo $SOURCEIP | sed -r 's/^.{8}(.{8}).*$/\1/g')"
s3="$(echo $SOURCEIP | sed -r 's/^.{16}(.{8}).*$/\1/g')"
s4="$(echo $SOURCEIP | sed -r 's/^.{24}(.{8}).*$/\1/g')"

SOURCEIP="$((2#$s1)).$((2#$s2)).$((2#$s3)).$((2#$s4))"

d1="$(echo $DESTINIP | sed -r 's/^(.{8}).*$/\1/g')"
d2="$(echo $DESTINIP | sed -r 's/^.{8}(.{8}).*$/\1/g')"
d3="$(echo $DESTINIP | sed -r 's/^.{16}(.{8}).*$/\1/g')"
d4="$(echo $DESTINIP | sed -r 's/^.{24}(.{8}).*$/\1/g')"

DESTINIP="$((2#$d1)).$((2#$d2)).$((2#$d3)).$((2#$d4))"

LENGTH="$((2#$LENGTH))"

DATA="$(echo $QUA | sed -r 's/^.{160}(.*)/\1/g')"
DATA="$(echo $DATA | sed -r 's/(.{8})/\1 /g')"
DATA="$(echo $DATA | perl -lape '$_=pack"(B8)*",@F')"

echo QUA:
echo
echo    $VERSION $IHL $TOS $LENGTH
echo    $ID $FLAGS $OFFSET
echo    $TTL $PROTOCOL $CHECKSUM
echo    $SOURCEIP
echo    $DESTINIP
echo        
echo    $DATA

echo $DATA > CLIENT1-CLIENT4-mensagem.txt
