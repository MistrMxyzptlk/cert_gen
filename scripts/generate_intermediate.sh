#! /bin/bash

cd /root/ca/intermediate

echo "Generace privátního klíče intermediate certifikátu:"

openssl genrsa -aes256 \
	-out private/intermediate.key.pem 4096

chmod 400 private/intermediate.key.pem

echo "Generace žádosti o podpis intermediate certifikátu:"

openssl req -config ./../openssl.cnf -new -sha256 \
	-key private/intermediate.key.pem \
	-out csr/intermediate.csr.pem

cd /root/ca

echo "Podepisování intermediate certifikátu:"

openssl ca -config openssl.cnf -extensions v3_intermediate_ca \
	-days 3650 -notext -md sha256 \
	-in intermediate/csr/intermediate.csr.pem \
	-out intermediate/certs/intermediate.cert.pem

chmod 444 intermediate/certs/intermediate.cert.pem

echo ""
echo "Zobrazování intermediate certifikátu:"
echo ""

openssl x509 -noout -text \
	-in intermediate/certs/intermediate.cert.pem

echo ""
echo "Kontrola platnosti intermediate certifikátu:"
echo ""

openssl verify -CAfile certs/ca.cert.pem \
	intermediate/certs/intermediate.cert.pem

echo ""
echo "Generace cert chain:"
echo ""

cat intermediate/certs/intermediate.cert.pem \
	certs/ca.cert.pem > intermediate/certs/ca-chain.cert.pem

chmod 444 intermediate/certs/ca-chain.cert.pem
