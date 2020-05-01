#!/bin/bash

CN="${CLIENT_CN}"
CLIENT_KEY_PASS="${CLIENT_KEY_PASS}"

if [ -z "$CN" ]
then
      echo "Please set SERVER_CN environment variable."
      exit 1;
fi

if [ -z "$CLIENT_KEY_PASS" ]
then
      echo "Please set CLIENT_KEY_PASS environment variable."
      exit 1;
fi

mkdir -p "$(dirname $0)/client_certs"
cd "$(dirname $0)/client_certs"

echo "\nGenerating KeyStore:\n"
keytool -genkey -keystore kafka.client.keystore.jks -validity 365 -storepass $CLIENT_KEY_PASS -keypass $CLIENT_KEY_PASS -dname "CN=$CN" -storetype pkcs12

echo "\nGenerating CSR:\n"
keytool -keystore kafka.client.keystore.jks -certreq -file csr -storepass $CLIENT_KEY_PASS -keypass $CLIENT_KEY_PASS

echo "\nGetting CSR Signed with the CA:\n"
openssl x509 -req -CA "../ca_authority/ca-cert" -CAkey "../ca_authority/ca-key" -in csr -out csr-signed -days 365 -CAcreateserial -passin pass:$CLIENT_KEY_PASS

echo "\nImport CA certificate in KeyStore:\n"
keytool -keystore kafka.client.keystore.jks -alias CARoot -import -file "../ca_authority/ca-cert" -storepass $CLIENT_KEY_PASS -keypass $CLIENT_KEY_PASS -noprompt

echo "\nImport Signed CSR In KeyStore :\n"
keytool -keystore kafka.client.keystore.jks -import -file csr-signed -storepass $CLIENT_KEY_PASS -keypass $CLIENT_KEY_PASS -noprompt

echo "\nImport CA certificate In TrustStore:\n"
keytool -keystore kafka.client.truststore.jks -alias CARoot -import -file  "../ca_authority/ca-cert" -storepass $CLIENT_KEY_PASS -keypass $CLIENT_KEY_PASS -noprompt
