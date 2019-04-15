#!/bin/bash

echo "Digite a mensagem que você deseja enviar" 
read MENSAGEM
echo "Digite o IP do destino"
read IP

echo
MacOrigem=$(cat /sys/class/net/$(ip route show default | awk '/default/ {print $5}')/address)
echo "MacAddress: $MacOrigem"

# solicita o MAC do endereço de IP
MACDESTINO=$(cat solicitaMAC.txt | netcat 172.16.252.72 1234)

# METODO 1 - O cliente recebe o arquivo do servidor e salva em um arquivo
# netcat 172.16.252.72 1234 > pdu_Cliente.txt

# METODO 2 - O cliente manda o aquivo para o IP do servidor
# cat quadro.txt | netcat 172.16.252.72 1234

MACSERVER=$(netcat 172.16.252.72 1234)
echo "MAC do Server $MACSERVER"