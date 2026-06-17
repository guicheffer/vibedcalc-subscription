#!/usr/bin/env bash
# check.sh - is this bean trustworthy?
#
# Run from the subscalc root:
#   bash eval-kit/check.sh eval-kit/beans/good-bean.md
#   bash eval-kit/check.sh eval-kit/beans/broken-bean.md
#
# A useful eval passes the good bean and fails the broken one.

BEAN="${1:?usage: check.sh <bean-file>}"
BODY="$(cat "$BEAN")"
pass() { echo "PASS  $1"; }
fail() { echo "FAIL  $1"; }

HLP="$(awk '/^## High-Level Plan$/{f=1;next} /^## /{f=0} f' <<<"$BODY")"

# 1. Planner stayed at altitude: High-Level Plan names no source file
grep -qE '\.(ts|css|js)\b' <<<"$HLP" \
  && fail "High-Level Plan names no source file" \
  || pass "High-Level Plan names no source file"

# 2. Refine ran: bean has a Refined Plan
grep -qx '## Refined Plan' <<<"$BODY" \
  && pass "Refined Plan is present" \
  || fail "Refined Plan is present"

# 3. Acceptance criteria are not a placeholder
grep -qi 'it works' <<<"$BODY" \
  && fail "acceptance criteria are real" \
  || pass "acceptance criteria are real"

# 4. Every existing path under Files to change actually exists
RFP="$(awk '/^### Files to change$/{f=1;next} /^### /{f=0} f' <<<"$BODY")"
ALL_PASS=true
while IFS= read -r line; do
  p="$(echo "$line" | grep -oE '^- [^ :]+' | sed 's/^- //')"
  [ -z "$p" ] && continue
  [[ "$p" == *":NEW"* ]] && continue
  [ -e "$p" ] || { fail "file exists: $p"; ALL_PASS=false; }
done <<<"$RFP"
$ALL_PASS && pass "all referenced files exist"
