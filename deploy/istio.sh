#!/bin/bash

function install() {
    echo "Installing istio..."
    # Configure the Helm repository
    helm repo add istio https://istio-release.storage.googleapis.com/charts
    helm repo update

    # Create a namespace istio-system for Istio components
    kubectl create namespace istio-system
    # Install the Istio base chart which contains cluster-wide resources used by the Istio control plane
    helm install istio-base istio/base -n istio-system
    # Install the Istio discovery chart which deploys the istiod service
    helm install istiod istio/istiod -n istio-system --wait

    # Install an ingress gateway
    kubectl create namespace istio-ingress
    kubectl label namespace istio-ingress istio-injection=enabled
    helm install istio-ingress istio/gateway -n istio-ingress --wait

}

function uninstall() {
    echo "Uninstalling istio..."
    helm delete istio-ingress -n istio-ingress
    kubectl delete namespace istio-ingress
    helm delete istiod -n istio-system
    helm delete istio-base -n istio-system
    kubectl delete namespace istio-system
}
