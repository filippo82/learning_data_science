# Kubernetes objects

## Pods
A pod is the most basic unit of the Kubernetes cluster. It usually contains one or more running containers. Pods are designed to be ephemeral in nature which means that they can be destroyed at any time. Containers in a pod share the same network, storage, and lifecycle. What this means is that they can communicate with each other directly, and will both be stopped and started at the same time.

## Replicaset
TBD

## Deployment
TBD

# DaemonSets
DaemonSet is another Kubernetes object that’s used for managing pods. DaemonSets are used when you want to make sure that a particular pod runs on all nodes that belong to a cluster. This is helpful in situations where you want to run a monitoring or logging application on the nodes in the cluster.

As soon as a node is added, to the cluster, DaemonSet spins up the pod in the node and destroys the pod as soon as the node exits.

# Namespace

Namespaces are used to organize objects in a Kubernetes cluster. They enable you to group resources together and perform actions on those resources. One of the use cases can be the creation of different environments (staging and development) for your deployed application. For example, you can create a deployment called backend-application with the staging namespace and deploy the same application in another namespace called production. While both deployments have the same name, there are no conflicts because of the difference in their namespaces.

# ConfigMap
ConfigMaps are used to separate configuration data from containers in your Kubernetes application. They offer you the ability to dynamically change data for containers at runtime. It’s important to note that ConfigMaps are not meant to be used for storing sensitive information. If the data you want to pass to your application is sensitive, then it is recommended you use Secrets instead.

