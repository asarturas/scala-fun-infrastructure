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

#### Required secrets

Backend relies on Pocket credentials being present as secrets
- pocket-access-token
- pocket-consumer-key

Example assumes you have them available as environment variables on creation:

```
kubectl create secret generic scala-fun \
    --from-literal="pocket-access-token=$POCKET_ACCESS_TOKEN" \
    --from-literal="pocket-consumer-key=$POCKET_CONSUMER_KEY"
```

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