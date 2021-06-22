#!/bin/bash


function units() {
  FLIST=$(find /etc/systemd/system -maxdepth 1 -type f)
  echo "systemd:"
  echo "  units:"
  for f in ${FLIST}; do 
    fname=$(basename "${f}")
    fcontent=$(cat "${f}" | sed 's/^/      /g' )

cat <<EOF
  - name: ${fname}
    enabled: true
    contents: |
${fcontent}
EOF
  done
  
}

units

# vim: ts=2 sw=2 et
