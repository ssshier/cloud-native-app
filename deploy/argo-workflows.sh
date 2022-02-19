#!/bin/bash

function install() {
    echo "Installing argo-workflows..."
    kubectl create namespace argo
    kubectl apply -n argo -f argo-workflows/manifests/install.yaml
}

function uninstall() {
    echo "Uninstalling argo-workflows..."
    kubectl delete --ignore-not-found -f argo-workflows/manifests/install.yaml
}
