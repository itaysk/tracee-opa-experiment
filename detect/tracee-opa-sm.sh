#! /bin/bash 

rego="$1"
[ -f "$rego" ] || exit 1
state_id="$(basename "$0" .sh)_$RANDOM"
state_path="./state/$state_id"
mkdir -p "$state_path"
state_file="$state_path/state.json"

rm "$state_file" &>/dev/null; mkfifo "$state_file"
exec 3<>"$state_file"
echo '{}' > "$state_file" &
while read -r line; do
  read -r state <"$state_file" #TODO: why can't give $state_file directly here?
  opa eval \
    --format bindings --fail \
    --data <(echo $state) \
    --data "$rego" \
    'state = data.example' \
    --stdin-input <<< "$line" \
  | jq '.' -cM \
  | tee >&3 \
      >(jq 'select(.state.detected == true)')
done 3>$state_file </dev/stdin 

exec 3>&-