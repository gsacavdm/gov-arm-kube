#!/bin/sh

# Abort on error
set -e

if [[ $# -eq 0 ]] ; then
  echo "Usage: apply.sh REGISTRY_SERVER"
  exit 1
fi

docker build . -t $1/secretvault