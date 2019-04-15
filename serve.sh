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



# METODO 1 - O cliente recebe o arquivo do servidor e salva em um arquivo
# cat quadro.txt | nc -l -p 1234

# METODO 2 - O cliente manda o aquivo para o IP do servidor
nc -l -p 1234 -q 1 > quadroServe.txt < /dev/null