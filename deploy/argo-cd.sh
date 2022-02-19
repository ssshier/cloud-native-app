#!/bin/bash

function install() {
    echo "Installing argocd..."
    kubectl create namespace argocd
    kubectl apply -n argocd -f argo-cd/manifests/install.yaml
}

function uninstall() {
    echo "Uninstalling argo-cd..."
    kubectl delete --ignore-not-found -f argo-cd/manifests/install.yaml
}
