#!/bin/bash
set -e

mkdir -p "$(dirname $0)/ca_authority"
cd "$(dirname $0)/ca_authority"

CN="${CA_AUTHORITY_CN}"

if [ -z "$CN" ]
then
      echo "/CN is empty"
      exit 1;
else
      echo "/CN=$CN"
      openssl req -new -newkey rsa:4096 -days 365 -x509 -subj "/CN=$CN" -keyout ca-key -out ca-cert -nodes
fi

