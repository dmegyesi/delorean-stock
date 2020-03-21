#!/usr/bin/env bash

mkdir -p output-tsv/

for file in output-raw-es/*.json; do

  jq -r \
  'select(.posibleComprar==true) | [.id, (.titleRecortado | gsub("[\\r\\n\\t]"; "")), ((.precioEntero|tostring) + "." + (.precioDecimal|tostring)), .stock, "es"] | @tsv' \
  "${file}"

done | tee output-tsv/stock-es.tsv
