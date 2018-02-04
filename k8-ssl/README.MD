# Setup SSL for the Docker registry
This tutorial will walk you through setting up SSL for [the Docker Registry you created](../registry/). SSL is setup using the [nginx ingress chart helm](https://github.com/nginxinc/kubernetes-ingress) and the [kube-lego helm chart](https://github.com/kubernetes/charts/tree/master/stable/kube-lego).

> **NOTE**: This tutorial requires you to own a domain and be able to create A records on it.

## Assumptions
This tutorial assumes that:
* You own a domain and are able to create A records on it.
* You want to create the registry at `registry.yourdomain.com`. 

## Instructions
1. Install Nginx
    ```bash
    helm install stable/nginx-ingress --name contoso-nginx --set rbac.create=true
    ```
1. Get external facing IP for ingress controller and add a DNS entry with your domain provider (e.g GoDaddy)
    ```
    kubectl get service contoso-nginx
    ```
1. Install Lets Encrypt
    ```bash
    helm install --name contoso-lego --set config.LEGO_EMAIL=you@domain.tld --set config.LEGO_URL=https://acme-v01.api.letsencrypt.org/directory stable/kube-lego --set rbac.create=true
    ```
1. Update the ingress `deployment.yaml` file with the domain for the registry.
    1. Line 11
        ```yaml
        spec:
          rules:
            - host: registry.contoso.com 
        ```
    1. Line 20
        ```yaml
        tls:
        - hosts:
          - registry.contoso.com 
        ```

1. Create Kubernetes ingress (sets up both nginx ingress and lego ingress)
    ```bash
    kubectl create -f deployment.yaml
    ```

## Outstanding Items
* Explain proxy body size limitation
    ```yaml
    ingress.kubernetes.io/proxy-body-size: 0m
    ```
* Explain `--set rbac.create=true`, Not necessary on 1.7, necessary on 1.8 with RBAC

## Next Steps
[Create the application container](container/)

## References
https://dgkanatsios.com/2017/07/07/using-ssl-for-a-service-hosted-on-a-kubernetes-cluster/
https://github.com/nginxinc/kubernetes-ingress
https://github.com/kubernetes/charts/tree/master/stable/kube-lego