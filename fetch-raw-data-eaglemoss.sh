#!/usr/bin/env bash
set -eo pipefail

if [[ -z "$1" ]]; then
  echo -e "No country selected, fetching all."
  COUNTRIES_TO_FETCH="au de eu fr it uk"
else
  COUNTRIES_TO_FETCH="${1}"
fi

set -u

mkdir -p "output-raw/"


fetch_stock_json() {
  local COUNTRY=$1
  local PAYLOAD=$2
  local API_SELECTOR=$3

  # shellcheck disable=SC2086
  curl -s \
  -XPOST \
  -H 'Content-Type: application/json' \
  -d ${PAYLOAD} \
  "https://shop.eaglemoss.com/${API_SELECTOR}/api/bundle" | jq -r . > "output-raw/eaglemoss-${COUNTRY}.json"

  echo -e "${COUNTRY}"
}



for COUNTRY in ${COUNTRIES_TO_FETCH}; do

  API_SELECTOR="${COUNTRY}/"
  PAYLOAD=""

  case "${COUNTRY}" in

    "au")
      PAYLOAD='{"requests":[{"action":"load","type":"page","verbosity":3,"plain":true,"children":[{"id":19,"_reqId":0},{"id":186,"_reqId":1}]},{"action":"route","plain":false,"children":[{"path":"/hero-collector/back-to-the-future-delorean","_reqId":2}]}]}'
      ;;

    "de")
      PAYLOAD='{"requests":[{"action":"load","type":"page","verbosity":3,"plain":true,"children":[{"id":1705,"_reqId":0},{"id":1747,"_reqId":1},{"id":1772,"_reqId":2}]},{"action":"route","plain":false,"children":[{"path":"/hero-collector/zuruck-in-die-zukunft-delorean","_reqId":3}]}]}'
      ;;

    "eu")
      PAYLOAD='{"requests":[{"action":"load","type":"page","verbosity":3,"plain":true,"children":[{"id":25964,"_reqId":0},{"id":352,"_reqId":1},{"id":353,"_reqId":2}]},{"action":"route","plain":false,"children":[{"path":"/hero-collector/back-to-the-future-delorean","_reqId":3}]}]}'
      ;;

    "fr")
      PAYLOAD='{"requests":[{"action":"load","type":"page","verbosity":3,"plain":true,"children":[{"id":1705,"_reqId":0},{"id":1747,"_reqId":1},{"id":1772,"_reqId":2}]},{"action":"route","plain":false,"children":[{"path":"/hero-collector/delorean-retour-vers-le-futur","_reqId":3}]}]}'
      ;;

    "it")
      PAYLOAD='{"requests":[{"action":"load","type":"page","verbosity":3,"plain":true,"children":[{"id":1706,"_reqId":0},{"id":1773,"_reqId":1}]},{"action":"route","plain":false,"children":[{"path":"/hero-collector/delorean-di-ritorno-al-futuro","_reqId":2}]}]}'
      ;;

    "uk")
      API_SELECTOR=""
      PAYLOAD='{"requests":[{"action":"load","type":"page","verbosity":3,"plain":true,"children":[{"id":12755,"_reqId":0},{"id":14370,"_reqId":1},{"id":14375,"_reqId":2}]},{"action":"route","plain":false,"children":[{"path":"/hero-collector/back-to-the-future-delorean","_reqId":3}]}]}'
      ;;

    *)
      echo "Error: unknown country."
      exit 1
      ;;
  esac

  fetch_stock_json "${COUNTRY}" "${PAYLOAD}" "${API_SELECTOR}"

done
