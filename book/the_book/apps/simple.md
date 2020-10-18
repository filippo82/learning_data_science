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

```bash
export KUBECONFIG=~/.kube/eksctl/clusters/cluster-test-1
```

eksctl enable repo -f eks_cluster.yaml

## Add Deploy Key to repo

Settings -> Deploy keys

Allow write access

