# CloudCart E-Commerce Microservices Project

CloudCart is a cloud-native e-commerce microservices project deployed on a Kubernetes cluster.
This project demonstrates how multiple backend services, frontend, database, cache, and ingress routing work together in a real microservices architecture.

## Project Overview

This project contains a complete e-commerce application setup with separate services for user management, authentication, products, inventory, cart, orders, payments, shipping, notifications, reviews, and API Gateway.

The application is containerized using Docker and deployed on Kubernetes using YAML manifests.

## Project Structure

```text
Cloudcart-Microservices/
├── database/
│   └── init.sql
├── frontend/
│   ├── Dockerfile
│   ├── index.html
│   ├── nginx.conf
│   ├── package.json
│   └── src/
├── k8s/
│   ├── namespace.yaml
│   ├── mysql-secret.yaml
│   ├── mysql-configmap.yaml
│   ├── mysql.yaml
│   ├── backend.yaml
│   ├── frontend.yaml
│   └── ingress.yaml
├── scripts/
│   └── deploy.sh
├── services/
│   ├── api-gateway/
│   ├── auth-service/
│   ├── user-service/
│   ├── product-service/
│   ├── inventory-service/
│   ├── cart-service/
│   ├── order-service/
│   ├── payment-service/
│   ├── shipping-service/
│   ├── notification-service/
│   └── review-service/
└── README.md
```

## Microservices

The project includes the following services:

| Service              | Purpose                                       |
| -------------------- | --------------------------------------------- |
| API Gateway          | Main entry point for backend requests         |
| Auth Service         | Handles login and authentication              |
| User Service         | Manages user details                          |
| Product Service      | Manages product information                   |
| Inventory Service    | Tracks stock and inventory                    |
| Cart Service         | Manages shopping cart items                   |
| Order Service        | Handles order creation and order details      |
| Payment Service      | Handles payment-related operations            |
| Shipping Service     | Manages shipping information                  |
| Notification Service | Sends notifications                           |
| Review Service       | Handles product reviews                       |
| Frontend             | User interface for the e-commerce application |

## Tools and Technologies Used

### Cloud and Infrastructure

* AWS
* EC2 Instances
* S3 Bucket for kOps state store
* kOps for Kubernetes cluster creation
* Kubernetes
* kubectl
* Calico networking
* Ingress NGINX Controller

### Containerization

* Docker
* Docker Hub

### Backend

* Node.js
* Express.js
* REST APIs
* Microservices architecture

### Frontend

* React
* Vite
* NGINX
* HTML
* CSS
* JavaScript

### Database and Cache

* MySQL 8.0

### DevOps and Deployment

* Kubernetes Deployments
* Kubernetes Services
* Kubernetes StatefulSet
* Kubernetes ConfigMaps
* Kubernetes Secrets
* Kubernetes Namespace
* Kubernetes Ingress
* Shell scripting
* Docker image build and push
* Rolling restart and rollout status checks

## Docker Images

Docker images are pushed to Docker Hub under the `vallivamsi` account.

Example images:

```text
vallivamsi/cloudcart-api-gateway:v1
vallivamsi/cloudcart-auth-service:v1
vallivamsi/cloudcart-user-service:v1
vallivamsi/cloudcart-product-service:v1
vallivamsi/cloudcart-inventory-service:v1
vallivamsi/cloudcart-cart-service:v1
vallivamsi/cloudcart-order-service:v1
vallivamsi/cloudcart-payment-service:v1
vallivamsi/cloudcart-shipping-service:v1
vallivamsi/cloudcart-notification-service:v1
vallivamsi/cloudcart-review-service:v1
vallivamsi/cloudcart-frontend:v1
```

## Kubernetes Namespace

All application resources are deployed inside the `ecommerce` namespace.

```bash
kubectl create namespace ecommerce
```

or using the manifest:

```bash
kubectl apply -f k8s/namespace.yaml
```

## Deployment Steps

### 1. Apply Kubernetes manifests

```bash
kubectl apply -f k8s/namespace.yaml
kubectl apply -f k8s/mysql-secret.yaml
kubectl apply -f k8s/mysql-configmap.yaml
kubectl apply -f k8s/mysql.yaml
kubectl apply -f k8s/backend.yaml
kubectl apply -f k8s/frontend.yaml
kubectl apply -f k8s/ingress.yaml
```

### 2. Check MySQL StatefulSet rollout

```bash
kubectl rollout status statefulset/mysql -n ecommerce --timeout=180s
```

### 3. Check pods

```bash
kubectl get pods -n ecommerce
```

### 4. Check services

```bash
kubectl get svc -n ecommerce
```

### 5. Check ingress

```bash
kubectl get ingress -n ecommerce
```

## Deployment Script

A deployment script is available inside the `scripts` folder.

Example:

```bash
chmod +x scripts/deploy.sh
./scripts/deploy.sh
```

The script applies all required Kubernetes manifests and checks the running resources.

## Useful Kubernetes Commands

Check all resources:

```bash
kubectl get all -n ecommerce
```

Check deployments:

```bash
kubectl get deploy -n ecommerce
```

Check pods:

```bash
kubectl get pods -n ecommerce
```

Describe a pod:

```bash
kubectl describe pod <pod-name> -n ecommerce
```

Check logs:

```bash
kubectl logs <pod-name> -n ecommerce
```

Restart all deployments:

```bash
kubectl rollout restart deployment -n ecommerce
```

Check images used by deployments:

```bash
kubectl get deploy -n ecommerce -o custom-columns=NAME:.metadata.name,IMAGE:.spec.template.spec.containers[*].image
```

## Cluster Setup

The Kubernetes cluster was created using kOps on AWS.

Main tools used for cluster setup:

* kOps
* kubectl
* AWS CLI
* AWS S3
* AWS EC2
* Calico networking

Example kOps state store:

```bash
export KOPS_STATE_STORE=s3://valli-kops-bkt
```

## Application Flow

```text
User
  ↓
Frontend
  ↓
Ingress Controller
  ↓
API Gateway
  ↓
Backend Microservices
  ↓
MySQL 
```

## Key Learning Outcomes

Through this project, I worked on:

* Creating a Kubernetes cluster using kOps
* Deploying a microservices-based application on Kubernetes
* Creating Docker images for frontend and backend services
* Pushing Docker images to Docker Hub
* Using Kubernetes Deployments, Services, Secrets, ConfigMaps, and StatefulSets
* Deploying MySQL inside Kubernetes
* Managing application routing using Ingress
* Troubleshooting ImagePullBackOff and deployment issues
* Restarting Kubernetes deployments using rollout commands
* Managing project source code using Git and GitHub

## Current Status

The project includes:

* Frontend application
* Multiple backend microservices
* MySQL database
* Kubernetes manifests
* Deployment script
* Dockerized services
* AWS kOps Kubernetes cluster setup



DevOps | AWS | Kubernetes | Docker | CI/CD
