#!/bin/bash

# $1 is name of certificate signing request
# $2 optional name of private key to sign with

if [[ $# < 1 || $# > 2 ]] ; then 
	echo "Musíte zadat argumenty (název csr)"
	exit 1
fi

cd /root/ca/intermediate

echo "Podepisování certifikátu:"

openssl ca -config openssl.cnf \
	-extensions server_cert -days 375 -notext -md sha256 \
	-in csr/$1.csr.pem \
	-out certs/$1.cert.pem

chmod 444 certs/$1.cert.pem

echo ""
echo "Zobrazování podepsaného certifikátu:"
echo ""

openssl x509 -noout -text \
	      -in certs/$1.cert.pem

