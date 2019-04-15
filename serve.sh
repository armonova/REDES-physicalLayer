#!/bin/bash

coproc netcat -l localhost 3000

while read -r cmd; do
  case "$cmd" in
    d) date ;;
    q) kill "$COPROC_PID"
       exit ;;
    *) echo "What?" ;;
  esac
done <&${COPROC[0]} >&${COPROC[1]}
