# # armazena o MAC do server em um arquivo
# cat /sys/class/net/$(ip route show default | awk '/default/ {print $5}')/address > AUX-MACServer.txt

# # METODO 1 - O cliente recebe o arquivo do servidor e salva em um arquivo
# # cat quadro.txt | nc -l -p 1234

# # METODO 2 - O cliente manda o aquivo para o IP do servidor
# while [[ 1 ]]; do
# 	echo

# 	RECEBE=$(nc -l -p 1234 -q 2)
# 	CHECK=${#RECEBE}
# 	if [ $CHECK -ge 10 ];
# 	then
# 		echo $CHECK
# 		cat AUX-checkSum.txt | nc -l -p 1234
# 		echo "$RECEBE" > "INTERNET1-SERVER1-quadro.txt"
# 		./SERVER-open-PDU.sh

# 	fi
# 	case "$RECEBE" in
# 		MAC)	cat AUX-MACServer.txt | nc -l -p 1234
# 				echo "MAC informado"
# 				cat AUX-MACServer.txt;;
# 		# *)		cat CLIENT3-CLIENT1-ACK.txt | nc -l -p 1234
# 		# 		echo "ACK informado"
# 		# 		cat CLIENT3-CLIENT1-ACK.txt
# 	esac
# done

# #

# # nc -l -p 1234 -q 1 > quadroServe.txt < /dev/null


# armazena o MAC do server em um arquivo
cat /sys/class/net/$(ip route show default | awk '/default/ {print $5}')/address > AUX-MACServer.txt

# METODO 1 - O cliente recebe o arquivo do servidor e salva em um arquivo
# cat quadro.txt | nc -l -p 1234

# METODO 2 - O cliente manda o aquivo para o IP do servidor
while [[ 1 ]]; do
	echo

	RECEBE=$(nc -l -p 1234 -q 2)
	CHECK=${#RECEBE}
	if [ $CHECK -ge 10 ];
	then
		echo $CHECK
		cat AUX-checkSum.txt | nc -l -p 1234
		echo "$RECEBE" > "INTERNET1-SERVER1-quadro.txt"
		./SERVER-open-PDU.sh

	fi
	case "$RECEBE" in
		MAC)	cat AUX-MACServer.txt | nc -l -p 1234
				echo "MAC informado"
				cat AUX-MACServer.txt;;
	esac
done

#

# nc -l -p 1234 -q 1 > quadroServe.txt < /dev/null