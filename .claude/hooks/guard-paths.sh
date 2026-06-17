#!/usr/bin/env bash
# guard-paths.sh <bean-id>
# Blocks implement if any existing path in ## Refined Plan does not exist.
# Catches hallucinated file paths before any code is touched.
set -euo pipefail
BEAN="${1:?usage: guard-paths.sh <bean-id>}"
BODY="$(beans show "$BEAN" --json | jq -r '.body')"
if [ -z "$BODY" ] || [ "$BODY" = "null" ]; then
  echo "GUARD FAIL: bean $BEAN has empty body" >&2; exit 1
fi
RFP="$(awk '/^### Files to change$/{f=1;next} /^### /{f=0} f' <<<"$BODY")"
FAILED=0
while IFS= read -r line; do
  p="$(echo "$line" | grep -oE '^- [^ :]+' | sed 's/^- //')"
  [ -z "$p" ] && continue
  [[ "$p" == *":NEW"* ]] && continue
  if [ ! -e "$p" ]; then
    echo "GUARD FAIL: hallucinated path $p does not exist" >&2
    FAILED=1
  fi
done <<<"$RFP"
[ "$FAILED" -eq 0 ] && echo "GUARD PASS: all referenced paths exist"
exit "$FAILED"
