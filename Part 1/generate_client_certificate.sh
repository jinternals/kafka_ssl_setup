#!/bin/bash

CLIENT_KEY_PASS="${CLIENT_KEY_PASS}"

if [ -z "$CLIENT_KEY_PASS" ]
then
      echo "Please set CLIENT_KEY_PASS environment variable."
      exit 1;
fi

mkdir -p "$(dirname $0)/client_certs"
cd "$(dirname $0)/client_certs"

echo "\nImport CA certificate In TrustStore:\n"
keytool -keystore kafka.client.truststore.jks -alias CARoot -import -file  "../ca_authority/ca-cert" -storepass $CLIENT_KEY_PASS -keypass $CLIENT_KEY_PASS -noprompt
