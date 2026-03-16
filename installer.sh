k3d cluster create IoT -p "8888:8888@loadbalancer"

kubectl create namespace argocd
kubectl create namespace dev

kubectl create -n argocd -f https://raw.githubusercontent.com/argoproj/argo-cd/stable/manifests/install.yaml
kubectl wait --for=condition=Ready pods --all -n argocd --timeout=300s
kubectl get secret argocd-initial-admin-secret -n argocd -o yaml | grep password | cut -d ":" -f2 | cut -d " " -f2 | base64 --decode > ../password.txt 

kubectl apply -f config/application.yaml
kubectl port-forward svc/argocd-server -n argocd 8080:443
