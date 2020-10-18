# README

[here](https://kubernetes.io/docs/concepts/services-networking/connect-applications-service/)


##

kubectl apply -f ./run-my-nginx.yaml
kubectl get pods -l run=my-nginx -o wide

kubectl get pods -l run=my-nginx -o yaml | grep podIP

kubectl expose deployment/my-nginx
or
kubectl apply -f ./nginx-svc.yaml

kubectl describe svc my-nginx

kubectl get ep my-nginx

kubectl exec my-nginx-75897978cd-rqzbh -- printenv | grep SERVICE

kubectl scale deployment my-nginx --replicas=0; kubectl scale deployment my-nginx --replicas=2;
kubectl get pods -l run=my-nginx -o wide
kubectl exec my-nginx-75897978cd-fnd8v -- printenv | grep SERVICE

kubectl get services kube-dns --namespace=kube-system

...

kubectl apply -f nginxsecrets.yaml
kubectl get secrets
