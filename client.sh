#!/bin/bash

echo "Digite a mensagem que você deseja enviar" 
read MENSAGEM
echo $MENSAGEM > mensagem.txt
echo "Digite o IP do destino"
read IPSERVER

# ---------------------------------------------
# PEGA O MAC DO CLIENTE
MACCLIENTE=$(cat /sys/class/net/$(ip route show default | awk '/default/ {print $5}')/address)
IPCLIENTE=172.16.251.78

# ---------------------------------------------
# SOLICITA O MAC DO SERVER

# Perguntia via protocolo ARP qual o endereço fisico do IP informado
# MACSERVER=$(arp 172.16.128.1 | awk 'FNR==2{ print $3 }')

# outra maneira de solicitar o MAC sem o protocolo ARP
cat solicitaMAC.txt | netcat $IPSERVER 1234
#172.16.251.78

# envia a mensagem para o servidor
MACSERVER=$(cat pdu.txt | netcat $IPSERVER 1234)

# MONTA A PDU
echo "IP SERVER: $IPSERVER"
echo "IP CLIENTE $IPCLIENTE"
./makePDU.sh $IPCLIENTE $IPSERVER

# ---------------------------------------------
# ENVIA O DADO PARA O DESTINO
echo
echo "MAC do Cliente: $MACCLIENTE"
echo "MAC do Server: $MACSERVER"
echo "IP Server: $IPSERVER"
echo "Mensagem: $MENSAGEM"


# METODO 1 - O cliente recebe o arquivo do servidor e salva em um arquivo
# netcat 172.16.252.72 1234 > pdu_Cliente.txt

# METODO 2 - O cliente manda o aquivo para o IP do servidor
# cat quadro.txt | netcat 172.16.252.72 1234

# MACSERVER=$(netcat 172.16.252.72 1234)
