#! /bin/bash 

rego="$1"
[ -f "$rego" ] || exit 1

while read -r line; do
  opa eval > /dev/null \
    --fail-defined \
    --format json --fail-defined \
    --data "$rego" \
    'res = data.example.detected' \
    --stdin-input <<< "$line" \
  || echo "$line"
done </dev/stdin