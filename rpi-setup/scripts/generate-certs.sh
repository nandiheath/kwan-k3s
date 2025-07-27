#!/bin/bash

# for detail steps:
# https://stackoverflow.com/questions/21297139/how-do-you-sign-a-certificate-signing-request-with-your-certification-authority

CERT_DIR="credentials/certs"

if [[ ! -d "$CERT_DIR/root-ca" ]]; then
  echo "$CERT_DIR/root-ca doesn't exist. prepare your root ca to generate intermediate certs"
  exit 1
fi


intermediate_key="$CERT_DIR/intermediate/key.pem"
intermediate_cert="$CERT_DIR/intermediate/cert.pem"
intermediate_csr="$CERT_DIR/intermediate/cert.csr"

if [[ ! -d "$CERT_DIR/intermediate" ]]; then
  mkdir -p "$CERT_DIR/intermediate"

  echo "generating private key for intermediate cert"
  openssl req \
      -new \
      -newkey rsa:4096 \
      -days 365 \
      -nodes \
      -sha256 \
      -subj "/C=CA/ST=Toronto/L=Springfield/O=Nandi/CN=nandi.sh" \
      -keyout $intermediate_key \
      -out $intermediate_csr
  touch "$CERT_DIR/intermediate/index.txt"
  echo '01' > "$CERT_DIR/intermediate/serial.txt"

  # verify CSR
  openssl req -text -noout -verify -in "$intermediate_csr"

cat << EOF > "$CERT_DIR/intermediate/openssl.cnf"
EOF
  openssl ca -create_serial -config "$CERT_DIR/intermediate/openssl.cnf" -policy signing_policy -extensions signing_req -cert "$CERT_DIR/root-ca/cert.pem" -keyfile "$CERT_DIR/root-ca/key.pem" -in "$intermediate_csr" -notext -out "$intermediate_cert"

  # verify the cert
  openssl x509 -purpose -in "$intermediate_cert" -text -noout
else
  echo "$CERT_DIR/intermediate already exists. abort generating "
fi

if [[ ! -d "$CERT_DIR/k3s" ]]; then
  echo "+++ Generate certs for k3s ..."

  mkdir -p "$CERT_DIR/k3s"

  cp "$CERT_DIR/root-ca/cert.pem" "$intermediate_key" "$intermediate_cert" "$CERT_DIR/k3s"

  curl -sL https://github.com/k3s-io/k3s/raw/master/contrib/util/generate-custom-ca-certs.sh | DATA_DIR="$CERT_DIR/k3s" bash -
  rm -rf /var/lib/rancher
else
  echo "$CERT_DIR/k3s already exists. abort generating "
fi







