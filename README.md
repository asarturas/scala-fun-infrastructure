# Scala.fun Infrastructure

All setup via Kubernetes (currently hosted on GCE)

Assumption is that you have `gcloud` setup with your current cluster and that `kubectl` is setup to talk to it.

## Frontend

#### Deploy

```
sh frontend/deploy.sh
```

#### Update deployment image (no need to have full config checked out):

```
kubectl set image deployments/scala-fun-frontend scala-fun-frontend=spikerlabs/scala-fun-frontend:VERSION_NUMBER
```

## Backend

#### Deploy

```
sh backend/deploy.sh
```

#### Update deployment image (no need to have full config checked out):

```
kubectl set image deployments/scala-fun-backend scala-fun-backend=spikerlabs/scala-fun-backend:VERSION_NUMBER
```

## Routing

#### Setup ingress

```
kubectl create -f ingress.yml
```

#### Update ingress

Edit the `ingress.yml` config as needed, and update it in cluster afterwards:
```
kubectl replace -f ingress.yml
```

#### Get ingress IP address

This may take a while to allocate an IP address (the "ADDRESS" column):
```
kubectl get ingress scala-fun
```