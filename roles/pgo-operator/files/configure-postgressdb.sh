#!/bin/bash
set -x
export PGO_OPERATOR_NAMESPACE="${1}"
export PATH=${3}/.pgo/${1}:$PATH
export PGOUSER=${3}/.pgo/${1}/pgouser
export PGO_CA_CERT=${3}/.pgo/${1}/client.crt
export PGO_CLIENT_CERT=${3}/.pgo/${1}/client.crt
export PGO_CLIENT_KEY=${3}/.pgo/${1}/client.key
export PGO_NAMESPACE=${1}

# Use for Testing
#pgo version --pgo-ca-cert ${PGO_CA_CERT} --pgo-client-cert ${PGO_CA_CERT} --pgo-client-key ${PGO_CLIENT_KEY} | tee /tmp/postgres-version.txt || exit $?
export PGO_APISERVER_URL="https://$(${2} -n "${1}" get route postgres-operator -o jsonpath="{.spec.host}")"
pgo create cluster coffeeshopdb --replica-count=2 --pgo-ca-cert ${PGO_CA_CERT} --pgo-client-cert ${PGO_CA_CERT} --pgo-client-key ${PGO_CLIENT_KEY} -n ${1} | tee /tmp/postgres-info.txt || exit $?

#/tmp/callme.sh