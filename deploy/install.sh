#!/bin/bash

function kuboard() {
    echo "Installing kuboard..."
    kubectl apply -f https://addons.kuboard.cn/kuboard/kuboard-v3.yaml
}

function argo-cd() {
    echo "Installing argocd..."
    kubectl create namespace argocd
    kubectl apply -n argocd -f argo-cd/manifests/install.yaml
}

function argo-workflows() {
    echo "Installing argo-workflows..."
    kubectl create namespace argo
    kubectl apply -n argo -f argo-workflows/manifests/install.yaml
}

function kube-prometheus() {
    echo "Installing prometheus..."
    # Create the namespace and CRDs, and then wait for them to be available before creating the remaining resources
    kubectl apply -f kube-prometheus/manifests/setup/
    sleep 10
    kubectl apply -f kube-prometheus/manifests/
    # Access dashboard
    # kubectl --namespace monitoring port-forward svc/prometheus-k8s 9090
    # kubectl --namespace monitoring port-forward svc/grafana 3000
    # kubectl --namespace monitoring port-forward svc/alertmanager-main 9093
}
