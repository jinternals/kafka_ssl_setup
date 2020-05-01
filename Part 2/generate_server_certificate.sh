#!/bin/bash

mkdir -p "$(dirname $0)/server_certs"
cd "$(dirname $0)/server_certs"

CN="${SERVER_CN}"
SERVER_KEY_PASS="${SERVER_KEY_PASS}"

if [ -z "$CN" ]
then
      echo "Please set SERVER_CN environment variable."
      exit 1;
fi

if [ -z "$SERVER_KEY_PASS" ]
then
      echo "Please set SERVER_KEY_PASS environment variable."
      exit 1;
fi

echo "\nGenerating KeyStore:\n"
keytool -genkey -keystore kafka.server.keystore.jks -validity 365 -storepass $SERVER_KEY_PASS -keypass $SERVER_KEY_PASS -dname "CN=$CN" -storetype pkcs12

echo "\nGenerating CSR:\n"
keytool -keystore kafka.server.keystore.jks -certreq -file csr -storepass $SERVER_KEY_PASS -keypass $SERVER_KEY_PASS

echo "\nGetting CSR Signed with the CA:\n"
openssl x509 -req -CA "../ca_authority/ca-cert" -CAkey "../ca_authority/ca-key" -in csr -out csr-signed -days 365 -CAcreateserial -passin pass:$SERVER_KEY_PASS

echo "\nImport CA certificate in KeyStore:\n"
keytool -keystore kafka.server.keystore.jks -alias CARoot -import -file "../ca_authority/ca-cert" -storepass $SERVER_KEY_PASS -keypass $SERVER_KEY_PASS -noprompt

echo "\nImport Signed CSR In KeyStore :\n"
keytool -keystore kafka.server.keystore.jks -import -file csr-signed -storepass $SERVER_KEY_PASS -keypass $SERVER_KEY_PASS -noprompt

echo "\nImport CA certificate In TrustStore:\n"
keytool -keystore kafka.server.truststore.jks -alias CARoot -import -file "../ca_authority/ca-cert" -storepass $SERVER_KEY_PASS -keypass $SERVER_KEY_PASS -noprompt
