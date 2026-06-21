#!/bin/bash
set -euo pipefail

kubectl apply -f k8s/namespace.yaml
kubectl apply -f k8s/mysql-secret.yaml
kubectl apply -f k8s/mysql-configmap.yaml
kubectl apply -f k8s/mysql.yaml
kubectl apply -f k8s/redis.yaml

kubectl rollout status statefulset/mysql -n ecommerce --timeout=180s

kubectl apply -f k8s/backend.yaml
kubectl apply -f k8s/frontend.yaml
kubectl apply -f k8s/ingress.yaml

kubectl rollout restart deployment/backend -n ecommerce
kubectl rollout restart deployment/frontend -n ecommerce

kubectl rollout status deployment/backend -n ecommerce --timeout=180s
kubectl rollout status deployment/frontend -n ecommerce --timeout=180s
