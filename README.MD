# Managing Secrets in Kubernetes in Azure Government
This repository walks you through setting an application in Kubernetes that pulls secrets from a KeyVault in Azure Government and makes it available to the application. The application is deployed to Kubernetes through a private Docker registry hosted in Kubernetes itself.

## Assumptions
TBD

## Instructions
1. [Create the Kubernetes cluster](k8-cluster/)
1. [Create the Docker registry](registry/)
1. [Setup SSL for the Docker registry](k8-ssl/)
1. [Create the application container](container/)
1. [Create the Azure KeyVault instance and secret](azure-keyvault/)
1. [Create the Kubernetes secret](k8-secret/)
1. [Create the Kubernetes deployment](k8-deployment/)

## Outstanding Items
TBD

## Next Steps
[Create the Kubernetes cluster](k8-cluster/)