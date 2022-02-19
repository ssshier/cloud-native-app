#!/bin/bash

HELM_TMP_FILE=helm-v3.8.0-linux-amd64.tar.gz

echo "Downloading helm..."
wget -c https://get.helm.sh/helm-v3.8.0-linux-amd64.tar.gz

echo "Verifying checksum... "
if [ "$(openssl sha1 -sha256 ${HELM_TMP_FILE} | awk '{print $2}')" != "8408c91e846c5b9ba15eb6b1a5a79fc22dd4d33ac6ea63388e5698d1b2320c8b" ]; then
    echo "SHA sum of ${HELM_TMP_FILE} does not match. Aborting."
    exit 1
fi

tar -zxvf helm-v3.8.0-linux-amd64.tar.gz
mv linux-amd64/helm /usr/bin/helm
