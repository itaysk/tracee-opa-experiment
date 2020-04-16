#! /bin/bash 

rego="$1"
[ -f "$rego" ] || exit 1
export state='{}'
while read -r line; do
  state=$(opa eval \
    --format bindings --fail \
    --data <(echo $state) \
    --data "$rego" \
    'state = data.example' \
    --stdin-input <<< "$line" \
    | jq '.' -cM)
  echo "$state"
  jq 'select(.state.detected == true)' <<<"$state"
done