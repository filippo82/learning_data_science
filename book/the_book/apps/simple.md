# Hello world

TBD

## New repo

Create a new repo, such as `filippo82/eks-gitops-test1`.

##

Create the `eks_cluster.yaml` file based on [this manifest](https://github.com/weaveworks/eksctl/blob/master/examples/21-eks-quickstart-app-dev.yaml):
```{{code-block}} yaml
Add file content here.
```

https://eksctl.io/usage/schema/

```{{code-block}} shell
eksctl create cluster \
-f eks_cluster.yaml \
--profile $AWS_PROFILE \
--auto-kubeconfig
```

`--auto-kubeconfig` save kubeconfig file by cluster name, e.g. `~/.kube/eksctl/clusters/hilarious-mongoose-1601767678`

```shell
export KUBECONFIG=~/.kube/eksctl/clusters/cluster-test-1
```

```shell
eksctl enable repo -f eks_cluster.yaml
```

## Add Deploy Key to repo

Settings -> Deploy keys

Allow write access

## Create simple Nginx web server

```shell
git add nginx-test.yaml
git commit -m "Add manifest and push"
git push
```

## Create ConfigMap to modify web server

```shell
git add nginx-configmap.yaml
git commit -m "Add configuration for Nginx"
git push
```

## Modify the Nginx deployment
Modify the Nginx deployment, namely the `nginx-test.yaml` file, to use the ConfigMap (see above) as a Volume.

```shell
git add nginx-test.yaml
git commit -m "Add Volume with ConfigMap"
git push
```

## Tear it down

```shell
kubectl get svc --all-namespaces
kubectl delete svc nginx
```


```shell
eksctl delete cluster \
    --profile $AWS_PROFILE \
    --name cluster-test-1
    --wait
```