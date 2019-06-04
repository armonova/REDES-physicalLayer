# #!/bin/bash

# echo "A mensagem que será enviada é" 
# cat CLIENT3-CLIENT1-segmento.txt
# echo "Digite o IP do destino"
# read IPSERVER

# # ---------------------------------------------
# # PEGA O MAC DO CLIENTE
# MACCLIENTE=$(cat /sys/class/net/$(ip route show default | awk '/default/ {print $5}')/address)
# IPCLIENTE=172.16.251.78

# # ---------------------------------------------
# # SOLICITA O MAC DO SERVER

# # Perguntia via protocolo ARP qual o endereço fisico do IP informado
# # MACSERVER=$(arp 172.16.128.1 | awk 'FNR==2{ print $3 }')

# # outra maneira de solicitar o MAC sem o protocolo ARP
# cat AUX-solicitaMAC.txt | netcat $IPSERVER 1234
# #172.16.251.78

# # envia a mensagem para o servidor
# MACSERVER=$(cat AUX-CATSERVER.txt | netcat $IPSERVER 1234)

# # retransmissão
# echo

# echo "MAC do Cliente: $MACCLIENTE"
# echo "MAC do Server: $MACSERVER"

# # MONTA A PDU
# echo
# echo "IP SERVER: $IPSERVER"
# echo "IP CLIENTE $IPCLIENTE"
# ./CLIENT-make-PDU.sh $IPCLIENTE $IPSERVER
# # ---------------------------------------------
# # CHECKSUM=$(cat CLIENTE-1-PDU.txt | netcat $IPSERVER 1234)
# RECEBE=10
# while [[ "$CHECKSUM" != 1000 && "$MACSERVER" != 1000 ]]; do
# 	echo $RECEBE
# 	RECEBE=$(cat CLIENT1-INTERNET1-quadro.txt | netcat $IPSERVER 1234)
# 	echo $RECEBE > "CLIENTE1-CLIENTE3-quadro.txt"

	
# done

# # METODO 1 - O cliente recebe o arquivo do servidor e salva em um arquivo
# # netcat 172.16.252.72 1234 > pdu_Cliente.txt

# # METODO 2 - O cliente manda o aquivo para o IP do servidor
# # cat quadro.txt | netcat 172.16.252.72 1234

# # MACSERVER=$(netcat 172.16.252.72 1234)


#!/bin/bash

echo "A mensagem que será enviada é" 
cat CLIENT3-CLIENT1-segmento.txt
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
cat AUX-solicitaMAC.txt | netcat $IPSERVER 1234
#172.16.251.78

# envia a mensagem para o servidor
MACSERVER=$(cat AUX-CATSERVER.txt | netcat $IPSERVER 1234)

# retransmissão
echo

echo "MAC do Cliente: $MACCLIENTE"
echo "MAC do Server: $MACSERVER"

# MONTA A PDU
echo
echo "IP SERVER: $IPSERVER"
echo "IP CLIENTE $IPCLIENTE"
./CLIENT-make-PDU.sh $IPCLIENTE $IPSERVER
# ---------------------------------------------
# CHECKSUM=$(cat CLIENTE-1-PDU.txt | netcat $IPSERVER 1234)
CHECKSUM=10
while [[ 1 ]]; 
do
	if [[ "$CHECKSUM" != 1000 && "$MACSERVER" != 1000 ]]; 
	then
		CHECKSUM=$(cat CLIENT1-INTERNET1-quadro.txt | netcat $IPSERVER 1234)
		echo $CHECKSUM
	fi
done

# METODO 1 - O cliente recebe o arquivo do servidor e salva em um arquivo
# netcat 172.16.252.72 1234 > pdu_Cliente.txt

# METODO 2 - O cliente manda o aquivo para o IP do servidor
# cat quadro.txt | netcat 172.16.252.72 1234

# MACSERVER=$(netcat 172.16.252.72 1234)