GitOps
======

## Resources

* [Is GitOps the next big thing in DevOps?](https://www.atlassian.com/git/tutorials/gitops)
* [GitOps on Gitlab's Topics](https://about.gitlab.com/topics/gitops/)
* []()
* []()
* []()
* []()
* []()
* []()

## Introduction

## Flux

https://toolkit.fluxcd.io/get-started/

export GITHUB_TOKEN=<your-token>
export GITHUB_USER=filippo82

brew install fluxcd/tap/flux

Create a cluster:
```{{code-block}} shell
eksctl create cluster \
--profile $AWS_PROFILE \
--name "Flux-V2-Test" \
--auto-kubeconfig
```

`--auto-kubeconfig` save kubeconfig file by cluster name, e.g. `~/.kube/eksctl/clusters/Flux-V2-Test`

```shell
export KUBECONFIG=~/.kube/eksctl/clusters/Flux-V2-Test
```

kubectl config get-contexts

flux check --pre
► checking prerequisites
✔ kubectl 1.19.4 >=1.18.0
✔ Kubernetes 1.18.9-eks-d1db3c >=1.16.0
✔ prerequisites checks passed

flux bootstrap github \
  --owner=$GITHUB_USER \
  --repository=eks-gitops-test2 \
  --branch=main \
  --path=staging-cluster \
  --personal
  ► connecting to github.com
  ✔ repository created
  ✔ repository cloned
  ✚ generating manifests
  ✔ components manifests pushed
  ► installing components in flux-system namespace
  namespace/flux-system created
  networkpolicy.networking.k8s.io/allow-scraping created
  networkpolicy.networking.k8s.io/allow-webhooks created
  networkpolicy.networking.k8s.io/deny-ingress created
  role.rbac.authorization.k8s.io/crd-controller-flux-system created
  rolebinding.rbac.authorization.k8s.io/crd-controller-flux-system created
  clusterrolebinding.rbac.authorization.k8s.io/cluster-reconciler-flux-system created
  customresourcedefinition.apiextensions.k8s.io/buckets.source.toolkit.fluxcd.io created
  customresourcedefinition.apiextensions.k8s.io/gitrepositories.source.toolkit.fluxcd.io created
  customresourcedefinition.apiextensions.k8s.io/helmcharts.source.toolkit.fluxcd.io created
  customresourcedefinition.apiextensions.k8s.io/helmrepositories.source.toolkit.fluxcd.io created
  service/source-controller created
  deployment.apps/source-controller created
  customresourcedefinition.apiextensions.k8s.io/kustomizations.kustomize.toolkit.fluxcd.io created
  deployment.apps/kustomize-controller created
  customresourcedefinition.apiextensions.k8s.io/helmreleases.helm.toolkit.fluxcd.io created
  deployment.apps/helm-controller created
  customresourcedefinition.apiextensions.k8s.io/alerts.notification.toolkit.fluxcd.io created
  customresourcedefinition.apiextensions.k8s.io/providers.notification.toolkit.fluxcd.io created
  customresourcedefinition.apiextensions.k8s.io/receivers.notification.toolkit.fluxcd.io created
  service/notification-controller created
  service/webhook-receiver created
  deployment.apps/notification-controller created
  Waiting for deployment "source-controller" rollout to finish: 0 of 1 updated replicas are available...
  deployment "source-controller" successfully rolled out
  deployment "kustomize-controller" successfully rolled out
  deployment "helm-controller" successfully rolled out
  deployment "notification-controller" successfully rolled out
  ✔ install completed
  ► configuring deploy key
  ✔ deploy key configured
  ► generating sync manifests
  ✔ sync manifests pushed
  ► applying sync manifests
  ◎ waiting for cluster sync
  ✔ bootstrap finished

git clone git@github.com:filippo82/eks-gitops-test2.git
cd eks-gitops-test2

flux create source git webapp \
    --url=https://github.com/stefanprodan/podinfo \
    --branch=master \
    --interval=30s \
    --export > ./staging-cluster/webapp-source.yaml

flux create kustomization webapp-common \
    --source=webapp \
    --path="./deploy/webapp/common" \
    --prune=true \
    --validation=client \
    --interval=1h \
    --export > ./staging-cluster/webapp-common.yaml

flux create kustomization webapp-backend \
  --depends-on=webapp-common \
  --source=webapp \
  --path="./deploy/webapp/backend" \
  --prune=true \
  --validation=client \
  --interval=10m \
  --health-check="Deployment/backend.webapp" \
  --health-check-timeout=2m \
  --export > ./staging-cluster/webapp-backend.yaml

flux create kustomization webapp-frontend \
--depends-on=webapp-backend \
--source=webapp \
--path="./deploy/webapp/frontend" \
--prune=true \
--validation=client \
--interval=10m \
--health-check="Deployment/frontend.webapp" \
--health-check-timeout=2m \
--export > ./staging-cluster/webapp-frontend.yaml

git add -A && git commit -m "add staging webapp" && git push

watch flux get kustomizations

kubectl -n webapp get deployments,services


kubectl port-forward -n webapp svc/frontend 9898:80

Access the frontend on:
localhost:9898

## Tear it down

```shell
kubectl get svc --all-namespaces
kubectl delete svc nginx
```


```shell
eksctl delete cluster \
    --profile $AWS_PROFILE \
    --name Flux-V2-Test \
    --wait
```
