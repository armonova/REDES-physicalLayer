#!/bin/bash

echo "Digite a mensagem que você deseja enviar" 
read MENSAGEM
echo "Digite o IP do destino"
read IP
MAC=$(cat /sys/class/net/enp1s0f1/address)
echo "$MAC"

# METODO 1 - O cliente recebe o arquivo do servidor e salva em um arquivo
# netcat 172.16.252.72 1234 > pdu_Cliente.txt

# METODO 2 - O cliente manda o aquivo para o IP do servidor
cat quadro.txt | netcat 172.16.252.72 1234