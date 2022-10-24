#!/bin/bash
# $1 - certificate algorithm
# $2 - certificate name
# $3 - certificate bits

if [[ $# != 3 ]] ; then
	echo "Musíte zadat argumenty (algorimus, název a velikost klíče - u el křivek vynechat)"
	exit 1
fi

cd /root/ca/intermediate

echo "Generace Privátního klíče:"

if [[ $1 == "rsa" ]] ; then
	openssl genrsa -aes256 \
		-out private/$1.key.pem $2
elif [[ $1 == "ek" ]] ; then
	openssl ecparam -out private/$1.key.pem \
		-name prime192v1 -genkey
else
	echo "neexistující algorimus"
	exit 1
fi	

chmod 400 private/$1.key.pem

echo "Generace žádosti o podpis certifikátu:"

openssl req -config openssl.cnf \
	-key private/$1.key.pem \
	-new -sha256 -out csr/$1.csr.pem
