# Create the Kubernetes cluster
Description

## Assumptions
None

## Instructions
1. Create your acs-engine `apimodel.json` file.
1. Use acs-engine to generate the Azure Resource Manager (ARM) template for the Kubernetes cluster.
1. Modify the generated `azuredeploy.parameters.json` file for Azure Government
1. Deploy the generated ARM template
1. Copy the certificates required from communication from the master
1. Configure your kubectl context
1. Test your kubectl connectivity with the cluster

## Outstanding Items
None

## References
None

## Next Steps
[Create the Docker registry](../registry/)