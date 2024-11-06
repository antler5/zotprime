#!/usr/bin/env bash
set -x

while true; do
  OUTPUT="$(su $USER docker compose up 2>&1 | tee /dev/stderr)"
  OUTPUT_EXIT=$?
  FILTERED="$(grep -Eo 'requested [0-9]+:[0-9]+' <<< "$OUTPUT")"
  # FILTERED="requested 4286438922:2038925"
  FILTERED_EXIT=$?
  if [[ -n $FILTERED ]]; then
    FILTERED=${FILTERED#requested }
    FIRST=${FILTERED##*:}
    SECOND=${FILTERED%%:*}
    if [[ $FIRST > $SECOND ]]; then
      HIGHEST=$FIRST
    else
      HIGHEST=$SECOND
    fi
    echo "antlers:64001:${HIGHEST}" > /etc/subuid
    echo "antlers:64001:${HIGHEST}" > /etc/subgid
    # # This doesn't actually work for some reason, that's why I tried wrapping
    # # it in a shell and sleeping (thought it might help), hence the emphasized
    # # break below.
    # su $USER /bin/bash -c 'podman system migrate' || exit 1
    # sleep 3
  else
    break
  fi
  # Hence _this_ break.
  break
done
