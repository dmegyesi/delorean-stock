#!/usr/bin/env bash
set -eo pipefail

if [[ -z "$1" ]]; then
  echo -e "No country selected, processing all."
  COUNTRIES_TO_FETCH="au de eu fr it uk"
else
  COUNTRIES_TO_FETCH="${1}"
fi

set -u

mkdir -p output-tsv/


generate_tsv_output() {
  local COUNTRY=$1
  local SOURCE_FILE="output-raw/eaglemoss-${COUNTRY}.json"
 
  if [ ! -f "${SOURCE_FILE}" ]; then
    echo -e "Error: there is no raw JSON data downloaded for this country."
    exit 1
  fi

  LIST_OF_IDS=$(jq -r '.catalog[] | select (.id==95) | .products[]' "${SOURCE_FILE}")

  for item in ${LIST_OF_IDS}; do
    jq -r \
      --argjson i "$item" \
      --arg COUNTRY "${COUNTRY}" \
      '[(.catalog[] | select (.type=="product") | select(.id==$i) | .sku, .name, .price), (.catalog[] | select (.type=="stock") | select(.id==$i) | if (.qty==null) then 0 else .qty end), $COUNTRY] | @tsv' \
      "${SOURCE_FILE}"
  done | grep "^DEL.*" | sort > "output-tsv/stock-${COUNTRY}.tsv"

  cat "output-tsv/stock-${COUNTRY}.tsv"

}


for COUNTRY in ${COUNTRIES_TO_FETCH}; do
  generate_tsv_output "${COUNTRY}"
done
