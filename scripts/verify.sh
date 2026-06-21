#!/bin/bash
set -euo pipefail
kubectl get pods -n ecommerce
kubectl get endpoints api-gateway auth-service product-service notification-service -n ecommerce
kubectl logs -n ecommerce deploy/api-gateway --tail=30 || true
kubectl exec -it deploy/redis -n ecommerce -- redis-cli DEL products:list || true
