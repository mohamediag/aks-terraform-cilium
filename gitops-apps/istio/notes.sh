## Generate Kube config
terraform output -raw kube_config > aks-kube.json
cp aks-kube.json /Users/doums/.kube/config 

## install argocd
kubectl create namespace argocd
kubectl apply -n argocd -f https://raw.githubusercontent.com/argoproj/argo-cd/stable/manifests/install.yaml

## Install app of apps pattern
kubectl apply -f gitops-apps/argo-apps/argo-apps.yaml

## Install Istio
kubectl create ns istio-system
helm template istio/base -n istio-system --set defaultRevision=default --create-namespace > istio_base.yaml
kubectl apply -f istio_base.yaml

helm template istiod istio/istiod -n istio-system > istio_istiod.yaml
kubectl apply -f istio_istiod.yaml

 helm template istio-ingress istio/gateway -n istio-ingress > istio_gateway.yaml
kubectl apply -f istio_gateway.yaml

