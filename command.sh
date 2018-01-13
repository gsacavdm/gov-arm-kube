#!/bin/bash

# Abort on error
set -e

# Delete secret file if exits
# (as silently does nothing if file exists)
[ -e tmp ] && rm tmp --recursive

# Download the secret
echo "Downloading secret"
az keyvault secret download --vault-name sacagov-vault -n sacasecret -f tmp/secret

# Read the value
SECRET=$(cat tmp/secret)

# FAILED ATTEMPT WITH SED
# This isn't reliable.
# If the secret has any
# "special character" this breaks.
# sed -i "s/<replaceSecret1>/$SECRET/g" secret.yaml

# Improve approach: Python
echo "Creating yaml file"
python replace.py $SECRET

echo "Deploying to Kubernetes"
#kubectl create -f tmp/secret.yaml
kubectl apply -f tmp/secret.yaml

echo "Deleting files"
rm tmp/*
