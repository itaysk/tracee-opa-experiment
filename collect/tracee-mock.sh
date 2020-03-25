#! /bin/bash

file="$1"
[ -f "$file" ] || exit 1

while true; do
  while read -r line; do
    echo "$line"
    sleep 1
  done <"$1"
done