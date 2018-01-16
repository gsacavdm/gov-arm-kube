#

From: https://dgkanatsios.com/2017/07/07/using-ssl-for-a-service-hosted-on-a-kubernetes-cluster/

```bash
helm install stable/nginx-ingress

helm install --set config.LEGO_EMAIL=you@domain.tld --set config.LEGO_URL=https://acme-v01.api.letsencrypt.org/directory stable/kube-lego

```

## Important Notes

```yaml
ingress.kubernetes.io/proxy-body-size: 0m
```

