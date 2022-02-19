#!/bin/bash

function argo-cd() {
    echo "Uninstalling argo-cd..."
    kubectl delete --ignore-not-found -f argo-cd/manifests/install.yaml
}

function argo-workflows() {
    echo "Uninstalling argo-workflows..."
    kubectl delete --ignore-not-found -f argo-workflows/manifests/install.yaml
}

function kube-prometheus() {
    echo "Uninstalling prometheus..."
    kubectl delete --ignore-not-found=true -f kube-prometheus/manifests/ -f kube-prometheus/manifests/setup
}
