#!/bin/bash

BDIR="$(realpath ${1})"

function directories() {
  DIRLIST=$(find ${BDIR} -type d )

  echo "  directories:"
  for d in ${DIRLIST}; do 
cat <<EOF
  - path: ${d}
EOF
  done
}


function files() {
  FLIST=$(find ${BDIR} -type f)
  echo "  files:"
  for f in ${FLIST}; do 
    finfo=$(stat  --printf "    mode: 0%a\n    user:\n      name: %U\n    group:\n      name: %G\n" "${f}")
    fzip=$(gzip -c "${f}" | base64 -w0 )
cat <<EOF
  - path: ${f}
    overwrite: true
    contents:
      compression: gzip
      source: data:;base64,${fzip}
${finfo}
EOF
  done
  
}

directories
files

# vim: ts=2 sw=2 et
