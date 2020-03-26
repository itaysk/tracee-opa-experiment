#! /bin/bash 

rego="$1"
[ -f "$rego" ] || exit 1
state_id="$(basename "$0" .sh)_$RANDOM"
state_path="./state/$state_id"
mkdir -p "$state_path"
state_file="$state_path/state.json"
newstate_file="$state_path/newstate.json"
[ -f "$state_file" ] || echo '{}' > "$state_file"

while read -r line; do
  opa eval \
    --format bindings --fail \
    --data "$state_file" \
    --data "$rego" \
    'state = data.example' \
    --stdin-input <<< "$line" \
  > "$newstate_file" 
  mv "$newstate_file" "$state_file"
  jq '.state.detected != true' "$state_file" -e >/dev/null || jq -c -M '.' "$state_file"
done </dev/stdin