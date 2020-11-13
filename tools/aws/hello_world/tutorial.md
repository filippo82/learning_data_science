---
title: 'AWS EKS - Tutorials'
disqus: hackmd
---

# AWS EKS Tutorials

[TOC]

## Tutorial 1

**How to run Serverless Kubernetes: AWS EKS on Fargate** from 
[Learn AWS | Build on AWS](https://www.learnaws.org/2019/12/16/running-eks-on-aws-fargate/).


Additional resources:
* ALB Ingress Controller [repository](https://github.com/kubernetes-sigs/aws-alb-ingress-controller)
* [AWS Knowledge Center](https://aws.amazon.com/premiumsupport/knowledge-center/eks-alb-ingress-controller-setup/)
* [AWS Blog](https://aws.amazon.com/blogs/containers/using-alb-ingress-controller-with-amazon-eks-on-fargate/)
* [AWS Blog](https://aws.amazon.com/blogs/opensource/kubernetes-ingress-aws-alb-ingress-controller/)

```bash
export AWS_ACCOUNT_ID=$(aws --profile swung sts get-caller-identity | python -c 'import json,sys;obj=json.load(sys.stdin);print(obj["Account"])')
export AWS_DEFAULT_REGION=eu-central-1
export AWS_CLUSTER_NAME=fargate-tutorial-cluster
export STACK_NAME=eksctl-$AWS_CLUSTER_NAME-cluster
export ALB_VERSION=v1.1.8
```

### Create a new cluster

```bash
eksctl create cluster \
--profile swung \
--name $AWS_CLUSTER_NAME \
--version 1.16 \
--region $AWS_DEFAULT_REGION \
--fargate \
--alb-ingress-access
```

### Verify cluster

```bash
kubectl get nodes
```

### Get VPC ID

```bash
eksctl get cluster \
--profile swung \
--name $AWS_CLUSTER_NAME \
--region $AWS_DEFAULT_REGION \
-o yaml
```
Inside the output, look for the line starting with `VpcId`:
```bash
VpcId: vpc-07939576cf757eb13
```

```bash
VPC_ID=$(aws cloudformation describe-stacks --stack-name "$STACK_NAME" | jq -r '[.Stacks[0].Outputs[] | {key: .OutputKey, value: .OutputValue}] | from_entries' | jq -r '.VPC')
```

### Setup the AWS ALB ingress controller

Version `1.1.8`

```bash
wget https://raw.githubusercontent.com/kubernetes-sigs/aws-alb-ingress-controller/$ALB_VERSION/docs/examples/rbac-role.yaml
wget https://raw.githubusercontent.com/kubernetes-sigs/aws-alb-ingress-controller/$ALB_VERSION/docs/examples/alb-ingress-controller.yaml
```

Inside `alb-ingress-controller.yaml`,
uncomment and edit:
* the `–cluster-name` flag to be the real name of the cluster;
* the `--aws-vpc-id` flag with the VPC name;
* the `--aws-region` flag with the correct AWS region;
* the value of `AWS_ACCESS_KEY_ID`;
* the value of `AWS_SECRET_ACCESS_KEY`.


### Deploy the modified alb-ingress-controller

```bash
kubectl apply -f rbac-role.yaml
```
The output is:
```bash
clusterrole.rbac.authorization.k8s.io/alb-ingress-controller created
clusterrolebinding.rbac.authorization.k8s.io/alb-ingress-controller created
serviceaccount/alb-ingress-controller created
```

```bash
kubectl apply -f alb-ingress-controller.yaml
```
The output is:
```bash
deployment.apps/alb-ingress-controller created
```

### Check the status of the ingress controller

```bash
kubectl logs -n kube-system $(kubectl get po -n kube-system | egrep -o "alb-ingress[a-zA-Z0-9-]+")
```
The output is:
```bash
-------------------------------------------------------------------------------
AWS ALB Ingress controller
  Release:    v1.1.8
  Build:      git-ec387ad1
  Repository: https://github.com/kubernetes-sigs/aws-alb-ingress-controller.git
-------------------------------------------------------------------------------

W0627 17:08:34.463965       1 client_config.go:549] Neither --kubeconfig nor --master was specified.  Using the inClusterConfig.  This might not work.
I0627 17:08:34.594067       1 controller.go:121] kubebuilder/controller "level"=0 "msg"="Starting EventSource"  "controller"="alb-ingress-controller" "source"={"Type":{"metadata":{"creationTimestamp":null}}}
I0627 17:08:34.649327       1 controller.go:121] kubebuilder/controller "level"=0 "msg"="Starting EventSource"  "controller"="alb-ingress-controller" "source"={"Type":{"metadata":{"creationTimestamp":null},"spec":{},"status":{"loadBalancer":{}}}}
I0627 17:08:34.649478       1 controller.go:121] kubebuilder/controller "level"=0 "msg"="Starting EventSource"  "controller"="alb-ingress-controller" "source"=
I0627 17:08:34.649822       1 controller.go:121] kubebuilder/controller "level"=0 "msg"="Starting EventSource"  "controller"="alb-ingress-controller" "source"={"Type":{"metadata":{"creationTimestamp":null},"spec":{},"status":{"loadBalancer":{}}}}
I0627 17:08:34.649892       1 controller.go:121] kubebuilder/controller "level"=0 "msg"="Starting EventSource"  "controller"="alb-ingress-controller" "source"=
I0627 17:08:34.650167       1 controller.go:121] kubebuilder/controller "level"=0 "msg"="Starting EventSource"  "controller"="alb-ingress-controller" "source"={"Type":{"metadata":{"creationTimestamp":null}}}
I0627 17:08:34.650640       1 controller.go:121] kubebuilder/controller "level"=0 "msg"="Starting EventSource"  "controller"="alb-ingress-controller" "source"={"Type":{"metadata":{"creationTimestamp":null},"spec":{},"status":{"daemonEndpoints":{"kubeletEndpoint":{"Port":0}},"nodeInfo":{"machineID":"","systemUUID":"","bootID":"","kernelVersion":"","osImage":"","containerRuntimeVersion":"","kubeletVersion":"","kubeProxyVersion":"","operatingSystem":"","architecture":""}}}}
I0627 17:08:34.654451       1 controller.go:121] kubebuilder/controller "level"=0 "msg"="Starting EventSource"  "controller"="alb-ingress-controller" "source"={"Type":{"metadata":{"creationTimestamp":null},"spec":{"containers":null},"status":{}}}
I0627 17:08:34.655371       1 leaderelection.go:205] attempting to acquire leader lease  kube-system/ingress-controller-leader-alb...
I0627 17:08:34.670510       1 leaderelection.go:214] successfully acquired lease kube-system/ingress-controller-leader-alb
I0627 17:08:34.670890       1 recorder.go:53] kubebuilder/manager/events "level"=1 "msg"="Normal"  "message"="alb-ingress-controller-7d76d56ccc-tqr7s_d5929d10-b898-11ea-938d-c66178edd3a9 became leader" "object"={"kind":"ConfigMap","namespace":"kube-system","name":"ingress-controller-leader-alb","uid":"4cd030e6-ebbb-463d-998e-d861ea43f698","apiVersion":"v1","resourceVersion":"6725"} "reason"="LeaderElection"
I0627 17:08:34.871149       1 controller.go:134] kubebuilder/controller "level"=0 "msg"="Starting Controller"  "controller"="alb-ingress-controller"
I0627 17:08:34.971363       1 controller.go:154] kubebuilder/controller "level"=0 "msg"="Starting workers"  "controller"="alb-ingress-controller" "worker count"=1
```

### Clone the repo

```bash
git clone https://github.com/abhishekray07/fargate-web-app/
```
The output is:
```bash

```

### Create a new repo on AWS Elastic Container Registry (ECR)

```bash
aws --profile swung ecr create-repository --repository-name fargate-tutorial
```
The output is:
```bash
{
    "repository": {
        "repositoryArn": "arn:aws:ecr:eu-central-1:533283293550:repository/fargate-tutorial",
        "registryId": "533283293550",
        "repositoryName": "fargate-tutorial",
        "repositoryUri": "533283293550.dkr.ecr.eu-central-1.amazonaws.com/fargate-tutorial",
        "createdAt": "2020-06-27T19:16:54+02:00",
        "imageTagMutability": "MUTABLE",
        "imageScanningConfiguration": {
            "scanOnPush": false
        }
    }
}
```

### Build a Docker image

```bash
docker build -t fargate-tutorial:1 .
docker tag fargate-tutorial:1 533283293550.dkr.ecr.eu-central-1.amazonaws.com/fargate-tutorial:1
```
The output is:
```bash

```

### Authenticate the Docker CLI for ECR

"${aws_account_id}.dkr.ecr.${aws_region}.amazonaws.com"
"533283293550.dkr.ecr.eu-central-1.amazonaws.com"

```bash
aws --profile swung ecr get-login-password | docker login --username AWS --password-stdin "533283293550.dkr.ecr.eu-central-1.amazonaws.com"
```
The output is:
```bash
WARNING! Your password will be stored unencrypted in /Users/filippo/.docker/config.json.
Configure a credential helper to remove this warning. See
https://docs.docker.com/engine/reference/commandline/login/#credentials-store

Login Succeeded
```

### Push the Docker image

```bash
docker push 533283293550.dkr.ecr.eu-central-1.amazonaws.com/fargate-tutorial:1
```
The output is:
```bash
The push refers to repository [533283293550.dkr.ecr.eu-central-1.amazonaws.com/fargate-tutorial]
b0c7b1622e76: Pushed
cd88b94e036a: Pushed
228b6bcead3e: Pushed
605bbee828fc: Pushed
fb12c5453842: Pushed
151a914ab9a4: Pushed
be340e26398b: Pushed
d7994f7c0aa0: Pushed
0bd71a837902: Pushed
13cb14c2acd3: Pushed
1: digest: sha256:f5fb8c4a938678a7368c9bd5485ec1a4defce134be6e22f6998234a55fdee2f7 size: 2416
```

### Deploy Application to EKS Cluster

#### Create new namespace and Fargate profile
```bash
eksctl create fargateprofile \
--profile swung \
--cluster $AWS_CLUSTER_NAME \
--region $AWS_DEFAULT_REGION \
--namespace python-web
```
The output is:
```bash
[ℹ]  creating Fargate profile "fp-00342dcc" on EKS cluster "JupyterHubFargateCluster"
[ℹ]  created Fargate profile "fp-00342dcc" on EKS cluster "JupyterHubFargateCluster"
```

```bash
kubectl apply -f kubernetes/namespace.yaml
```
The output is:
```bash
namespace/python-web created
```
```bash=
kubectl get ns
```


#### Create a service

```bash
kubectl apply -f kubernetes/service.yaml
```
The output is:
```bash
service/python-web created
```
```bash
kubectl get svc -n python-web
```
The output is:
```bash
NAME         TYPE       CLUSTER-IP       EXTERNAL-IP   PORT(S)        AGE
python-web   NodePort   10.100.196.232   <none>        80:32043/TCP   115s
```

#### Deploy the application

Modify the `image` entry inside the `kubernetes/deployment.yaml` file.

```bash
kubectl apply -f kubernetes/deployment.yaml
```
The output is:
```bash
deployment.apps/python-web created
```

```bash
kubectl get pods -n python-web
```
The output is:
```bash
NAME                         READY   STATUS    RESTARTS   AGE
python-web-f8f775c66-zpn2r   1/1     Running   0          87s
```

#### Deploy the Ingress resource

:::info
AWS ALB Ingress controller supports two traffic modes: instance mode and ip mode. Users can explicitly specify these traffic modes by declaring the `alb.ingress.kubernetes.io/target-type` annotation on the Ingress and the service definitions.
**Note:** If you are using the ALB ingress with EKS on Fargate you want to use `ip` mode.
:::

```bash
kubectl apply -f kubernetes/ingress.yaml
```
The output is:
```bash
ingress.extensions/python-web created
```

```bash
kubectl get pods -n python-web
```
The output is:
```bash
NAME                         READY   STATUS    RESTARTS   AGE
python-web-f8f775c66-zpn2r   1/1     Running   0          3h32m
```

```bash
kubectl get ingress/python-web -n python-web
```
The output is:
```bash
NAME         HOSTS   ADDRESS                                                                    PORTS   AGE
python-web   *       e12b04a6-pythonweb-pythonw-0d03-355333283.eu-central-1.elb.amazonaws.com   80      4h4m
```

#### Check the status of the ingress

```bash
kubectl describe ing -n python-web python-web
```
The output is:
```bash
Name:             python-web
Namespace:        python-web
Address:          e12b04a6-pythonweb-pythonw-0d03-355333283.eu-central-1.elb.amazonaws.com
Default backend:  default-http-backend:80 (<error: endpoints "default-http-backend" not found>)
Rules:
  Host        Path  Backends
  ----        ----  --------
  *
              /   python-web:80 (192.168.179.10:8080)
Annotations:  alb.ingress.kubernetes.io/scheme: internet-facing
              alb.ingress.kubernetes.io/target-type: ip
              kubernetes.io/ingress.class: alb
Events:
  Type    Reason  Age    From                    Message
  ----    ------  ----   ----                    -------
  Normal  CREATE  5m33s  alb-ingress-controller  LoadBalancer e12b04a6-pythonweb-pythonw-0d03 created, ARN: arn:aws:elasticloadbalancing:eu-central-1:533283293550:loadbalancer/app/e12b04a6-pythonweb-pythonw-0d03/5f11614fa350f265
  Normal  CREATE  5m32s  alb-ingress-controller  rule 1 created with conditions [{    Field: "path-pattern",    PathPatternConfig: {      Values: ["/*"]    }  }]
  Normal  MODIFY  4m8s   alb-ingress-controller  rule 1 modified with conditions [{    Field: "path-pattern",    PathPatternConfig: {      Values: ["/"]    }  }]
```

#### Check the ALB Ingress Controller Logs

```bash
kubectl logs -n kube-system deployment.apps/alb-ingress-controller
```


#### Test the application!

```bash
curl e12b04a6-pythonweb-pythonw-0d03-355333283.eu-central-1.elb.amazonaws.com
```
The output is:
```bash
Hello, World!
```

### Clean up the application

```bash
kubectl delete -f kubernetes/namespace.yaml
```

### Delete the cluster

```bash
eksctl delete cluster \
--profile swung \
--name $AWS_CLUSTER_NAME \
--region $AWS_DEFAULT_REGION
```

## Tutorial 2


```bash
eksctl create fargateprofile --profile swung --cluster JupyterHubFargateCluster --region $AWS_DEFAULT_REGION --namespace 2048-game
```
```bash
kubectl apply -f https://raw.githubusercontent.com/kubernetes-sigs/aws-alb-ingress-controller/$ALB_VERSION/docs/examples/2048/2048-namespace.yaml
kubectl apply -f https://raw.githubusercontent.com/kubernetes-sigs/aws-alb-ingress-controller/$ALB_VERSION/docs/examples/2048/2048-deployment.yaml
kubectl apply -f https://raw.githubusercontent.com/kubernetes-sigs/aws-alb-ingress-controller/$ALB_VERSION/docs/examples/2048/2048-service.yaml
kubectl apply -f https://raw.githubusercontent.com/kubernetes-sigs/aws-alb-ingress-controller/$ALB_VERSION/docs/examples/2048/2048-ingress.yaml
```

```bash
kubectl get ingress/2048-ingress -n 2048-game
```

###### tags: `AWS` `EKS`