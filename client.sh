#!/bin/bash

nc localhost 3000

case

while read -r cmd; do
  case "$cmd" in
    d) d
    q) q
    *) outros
  esac
