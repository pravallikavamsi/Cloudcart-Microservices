# CloudCart E-Commerce Microservices

Generated fixed project by create_cloudcart_fixed.sh.

## Build and deploy

```bash
export DOCKER_USER=pravallikavamsi
export IMAGE_TAG=v1
./scripts/build-push.sh
./scripts/deploy.sh
```

## Verify

```bash
./scripts/verify.sh
kubectl get ingress -n ecommerce
```

Use the Ingress LoadBalancer DNS from ingress-nginx controller service.
