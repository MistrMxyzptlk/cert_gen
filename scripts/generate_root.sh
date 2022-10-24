#! /bin/bash

cd /root/ca

echo " +-----------------------------------------------+"
echo " | generating private key for CA                 |"
echo " | Result will be stored in ./private/ca.key.pem |"
echo " +-----------------------------------------------+"
openssl genrsa -aes256 -out private/ca.key.pem 4096

chmod 400 private/ca.key.pem

echo " +----------------------------------------------+"
echo " | Generating CA from ./private/ca.key.pem      |"
echo " | Result will be stored in ./certs/ca.cert.pem |"
echo " +----------------------------------------------+"
openssl req -config openssl.cnf \
	-key private/ca.key.pem \
	-new -x509 -days 7300 -sha256 -extensions v3_ca \
	-out certs/ca.cert.pem

chmod 444 certs/ca.cert.pem
