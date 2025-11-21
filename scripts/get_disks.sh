#!/bin/bash
# Forzamos JSON vacío si el comando falla
output=$(df -h --output=target,pcent,size -x tmpfs -x devtmpfs -x squashfs -x overlay 2>/dev/null | tail -n +2 | \
jq -R -s '
  split("\n")[:-1] | 
  map(split(" ") | map(select(length > 0))) | 
  map({
    "mount": .[0], 
    "perc": .[1] | sub("%";"") | tonumber, 
    "size": .[2]
  })
' 2>/dev/null)

if [ -z "$output" ]; then
    echo "[]"
else
    echo "$output"
fi
