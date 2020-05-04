#! /bin/bash

[ -n "$TRACEE_MSTEAMS_WEBHOOK" ] || exit 1

while read -r line; do
  safeline=${line//'"'/'\"'}
  curl "$TRACEE_MSTEAMS_WEBHOOK" \
    -H "Content-Type: application/json" \
    -d "{\"text\": \" Tracee alert: <pre> $safeline </pre>\" }" \
    -s > /dev/null
done