#!/bin/sh

CERTS_PATH="/etc/nginx/certs"

openssl genrsa -out $CERTS_PATH/private.key 2048
openssl req -new -key $CERTS_PATH/private.key -out $CERTS_PATH/csr.csr -subj "/C=MY/ST=KL/L=KL/O=42/OU=42KL/CN=Hiro"
openssl x509 -req -days 365 -in $CERTS_PATH/csr.csr -signkey $CERTS_PATH/private.key -out $CERTS_PATH/certificate.crt


