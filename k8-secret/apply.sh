#!/bin/bash

# Abort on error
set -e

if [[ $# -eq 0 ]] ; then
  echo "Usage: apply.sh AZURE_NAMING_PREFIX"
  exit 1
fi

# Ensure our tmp folder exists and is clean.
# (as az keyvault download is fragile and fails silently)
[ ! -e tmp ] && mkdir tmp
[ -e tmp ] && rm tmp/* -f

# Download the secret
echo "Downloading secret"
az keyvault secret download --vault-name $1-vault -n $1-secret -f tmp/secret

# Read the value
SECRET=$(cat tmp/secret)

# FAILED ATTEMPT WITH SED
# This isn't reliable.
# If the secret has any
# "special character" this breaks.
# sed -i "s/<replaceSecret1>/$SECRET/g" secret.yaml

# Improve approach: Python
echo "Creating yaml file"
python replace.py "$SECRET"

echo "Deploying to Kubernetes"
#kubectl create -f tmp/secret.yaml
kubectl apply -f tmp/secret.yaml

echo "Deleting files"
rm tmp --recursive
