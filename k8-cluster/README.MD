# Create the Kubernetes cluster
Description

## Assumptions
None

## Instructions
1. Download [acs-engine](https://github.com/Azure/acs-engine/releases). Make sure you download release v.0.13.2 or greater, previous versions don't work properly with Azure Government.

1. Create your own acs-engine `apimodel.json` file.

    ```bash
    cp apimodel.json apimodel.my.ignore.json
    ```

1. Modify the following values in your `apimodel.my.ignore.json` file:
    * `dnsPrefix`: The dns name you want for the cluster. For example `contoso` will result in `https://contoso.usgovvirginia.cloudapp.usgovcloudapi.net`
    * `keyData`: The public SSH key to SSH into the Kubernetes cluster. See [How to create and use an SSH public and private key pair for Linux VMs in Azure](https://docs.microsoft.com/azure/virtual-machines/linux/mac-create-ssh-keys).
    * `clientId` and `secret`: The client id and secret for the Azure AD service principal that Kubernetes will use to communicate with Azure Government (create load balancers, request public IPs, access Azure storage, etc). See [Create an Azure service principal with Azure CLI 2.0](https://docs.microsoft.com/cli/azure/create-an-azure-service-principal-azure-cli?view=azure-cli-latest).

1. Obtain your Subscription ID. You can do this from the Azure portal, using Powershell or via the Azure CLI:

    Via Azure CLI:

    ```
    az cloud set --n AzureUSGovernment
    az login
    az account list
    ```

1. Use acs-engine to deploy your template to Azure Government. This takes up to 30 minutes for 3 nodes.

    ```bash
    acs-engine deploy --api-model apimodel.my.ignore.json --subscription-id <YOUR_SUB_ID> --location usgovvirginia --azure-env AzureUSGovernmentCloud
    ```

1. Configure your kubectl context. This configuration is per bash session. You'll need to run this command for every session:

    ```bash
    export KUBECONFIG=$(pwd)/_output/<DNS-PREFIX>/kubeconfig/kubeconfig.usgovvirginia.json
    ```

    Alternatively, you can replace your kubectl config file with the one in the command above for your configuration to persist across sessions. 
    
    > WARNING: This will replace any existing configurations.

    ```bash
    cp $(pwd)/_output/<DNS-PREFIX>/kubeconfig/kubeconfig.usgovvirginia.json ~/.kube/config
    ```

1. Test your kubectl connectivity with the cluster

    ```bash
    kubectl get pods
    ```

## Outstanding Items
None

## References
None

## Next Steps
[Create the Docker registry](../registry/)