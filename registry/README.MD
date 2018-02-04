# Create the Docker Registry
(Inside of Kubernetes since Azure Container Registry isn't available in Azure Government)

## Naming Convention
TBD

## Assumptions
TBD

## Instructions
1. Create Azure Storage account for registry Azure File Share
    ```bash
    az storage account create -g <RESOURCE_GROUP> -n <ACCOUNT_NAME> -l <LOCATION>
    az storage share create --account-name <ACCOUNT_NAME> -n registry
    ```
1. Copy template to .ignore file (.ignore extension prevents accidental commit of the file with secrets)
    ```bash
    cp registry/deployment.secret.yaml registry/deployment.secret.yaml.ignore
    ```
1. Get Azure Storage account name and key, base 64 encode it, and replace it in `deployment.secret.yaml.ignore`
    ```bash
    base64 <ACCOUNT_NAME>
    #Copy this value into the yaml.ignore file's azurestorageaccountname

    az storage account keys list -g <RESOURCE_GROUP> -n <ACCOUNT_NAME>
    base64 <KEY1_VALUE>
    #Copy this value into the yaml.ignore file's azurestorageaccountkey
    ```
1. Deploy Azure Storage secret
    ```bash
    kubectl create -f registry/deployment.secret.yaml.ignore
    ```
1. Deploy registry
    ```bash
    kubectl create -f registry/deployment.yaml
    ```
1. Expose registry
    ```bash
    kubectl expose service registry
    ```

**IGNORE - ONLY NEEDED IF NOT USSING SSL** (nginx ingress & lego ingress)
1. Expose as LoadBalancer instead of default ClusterIP:
    ```bash
    kubectl expose deployment registry --type=LoadBalancer
    ```
1. Get the public IP address for hte registry
    ```bash
    kubectl get service registry
    ```
1. Add a DNS name to that IP in Azure
    ```bash
    az network public-ip update -n <NAME_OF_IP> -g <RESOURCE_GROUP> --dns-name <NAMING_PREFIX>-registry
    ```

## Outstanding Items
* Create storage account through ARM template
* Scale (at least add another replica)
  * Start with 1 replica (`docker push` doesn't work across multiple)
  * Then add more replicas for `docker pull`?
* Add SSL cert and DNS entry
* Add Auth
* Make service part of config not a command

## Next Steps
[Setup SSL for the Docker registry](../k8-ssl/)

## References
https://docs.docker.com/registry/
https://docs.docker.com/registry/deploying/