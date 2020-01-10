

# Installation

## Linux

### Install `kubectl`
If the Google Cloud SDK was previously installed following these [instructions](https://cloud.google.com/sdk/docs/downloads-apt-get),
we can easily install `kubectl` using `apt-get`:
```shell
sudo apt-get install kubectl
kubectl version --output=yaml
```
### Install Minikube
```shell
curl -Lo minikube https://storage.googleapis.com/minikube/releases/latest/minikube-linux-amd64 && chmod +x minikube && sudo mv minikube /usr/local/bin/
```

# Create a cluster with Minikube

```shell
minikube start --vm-driver=virtualbox
minikube status
```

## Check environment variables

```shell
minikube docker-env
eval $(minikube docker-env)
```

## Inspect the cluster

### List the containers
```shell
docker container ls
```
## 
```shell
kubectl config current-context
```
## List cluster nodes
```shell
kubectl get nodes
```
##
```shell
```
##
```shell
```
##
```shell
```
