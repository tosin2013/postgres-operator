#!/bin/bash

set -x
export PGO_OPERATOR_NAMESPACE="${1}"
export PATH=/root/.pgo/${1}:$PATH
export PGOUSER=/root/.pgo/${1}/pgouser
export PGO_CA_CERT=/root/.pgo/${1}/client.crt
export PGO_CLIENT_CERT=/root/.pgo/${1}/client.crt
export PGO_CLIENT_KEY=/root/.pgo/${1}/client.key
export PGO_NAMESPACE=${1}

export PGO_APISERVER_URL="https://$(${2} -n "${1}" get route postgres-operator -o jsonpath="{.spec.host}")"

pgo delete cluster coffeeshopdb  --delete-backups --no-prompt -n ${1}