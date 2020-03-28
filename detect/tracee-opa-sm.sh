#! /bin/bash 
set -x
rego="$1"
[ -f "$rego" ] || exit 1
state_id="$(basename "$0" .sh)" #_$RANDOM"
state_path="./state/$state_id"
mkdir -p "$state_path"
state_file="$state_path/state"
rm "$state_file" && mkfifo "$state_file" 
#exec 3<>"$state_file"
echo '{}' >$state_file &
cat $state_file
#exec 3<>&-

exit
while read -r line; do
  opa eval \
    --format bindings --fail \
    --data <(cat - <&3) \
    --data "$rego" \
    'state = data.example' \
    --stdin-input <<< "$line" \
  | jq '.'
  #| jq 'if .state.detected == true then . else "" end' -c -M
done </dev/stdin
