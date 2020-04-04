#!/usr/bin/env bash

BASE_URL="https://www.planetadeagostini.es/coleccion/entregaAjax?bean=1&identrega="
ID_PREFIX="011M87"
# SUFFIX: 001 ... 999

mkdir -p output-raw-es/

# So far they only published the first 159 issues in the database
for id in {001..159}; do
  FILE="output-raw-es/${id}.json"

  curl -s "${BASE_URL}${ID_PREFIX}${id}" | jq -r . > "${FILE}"
  echo -e "${id}"

done
