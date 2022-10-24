#! /bin/bash

echo "generating dirs for CA"

mkdir -p /root/ca
cd /root/ca
mkdir -p certs crl newcerts private
chmod 700 private
touch index.txt
echo 1000 > serial

echo "generating dirs for intermediate certs"

mkdir -p /root/ca/intermediate
cd /root/ca/intermediate
mkdir -p certs crl csr newcerts private
chmod 700 private
touch index.txt
echo 1000 > serial
echo 1000 > /root/ca/intermediate/crlnumber
