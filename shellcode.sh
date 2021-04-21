#!/bin/bash

function stop() { exit 0; }

if [[ -z $1 ]]; then echo "Veuillez préciser un fichier binaire"; stop; fi
if [[ ! -f $1 ]]; then echo "Ce fichier n'existe pas"; stop; fi
for opcode in `objdump -d $1 | grep "[0-9a-f]:" | sed 's/[0-9a-f]*://' | sed 's/\s\{2,\}/ /g' | awk -F " " '{n=split($0,tab," "); for(i=0;i<n;i++) {if(tab[i] ~ /^[a-f0-9]{2}$/){print tab[i]}}}'`
do echo -n "\\x$opcode"; done
