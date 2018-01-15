# Create the Docker Registry
(Inside of Kubernetes since Azure Container Registry isn't available in Azure Government)

1. `kubectl create -f registry/deployment.yaml`
1. `kubectl expose deployment registry --type=LoadBalancer`
1. `kubectl get service registry`
1. `az network public-ip update -n <NAME_OF_IP> -g <RESOURCE_GROUP> --dns-name <NAMING_PREFIX>-registry`

## Outstanding Items
* Add persistent volume
* Scale (at least add another replica)
* Add SSL cert and DNS entry
* Add Auth
* Make service part of config not a command



