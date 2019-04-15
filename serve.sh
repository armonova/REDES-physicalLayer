#!/bin/bash

# coproc netcat -l localhost 3000

# while read -r cmd; do
#   case "$cmd" in
#     d) date ;;
#     q) kill "$COPROC_PID"
#        exit ;;
     #*) echo "What?" ;;
#   esac
# done <&${COPROC[0]} >&${COPROC[1]}


# armazena o MAC do server em um arquivo
cat /sys/class/net/$(ip route show default | awk '/default/ {print $5}')/address > MACServer.txt

# METODO 1 - O cliente recebe o arquivo do servidor e salva em um arquivo
# cat quadro.txt | nc -l -p 1234

# METODO 2 - O cliente manda o aquivo para o IP do servidor
while [[ 1 ]]; do
	RECEBE=$(nc -l -p 1234 -q 1)
	echo "Recebido: $RECEBE"
	case "$RECEBE" in
		MAC)	cat MACServer.txt | nc -l -p 1234;;
		*) 		echo "Não entrou"
	esac
done


# nc -l -p 1234 -q 1 > quadroServe.txt < /dev/null
