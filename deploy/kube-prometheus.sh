#!/bin/bash

function install() {
    echo "Installing prometheus..."
    # Create the namespace and CRDs, and then wait for them to be available before creating the remaining resources
    kubectl apply -f kube-prometheus/manifests/setup
    sleep 10
    kubectl apply -f kube-prometheus/manifests/
    # Access dashboard
    # kubectl --namespace monitoring port-forward svc/prometheus-k8s 9090
    # kubectl --namespace monitoring port-forward svc/grafana 3000
    # kubectl --namespace monitoring port-forward svc/alertmanager-main 9093
}

function uninstall() {
    echo "Uninstalling prometheus..."
    kubectl delete --ignore-not-found=true -f kube-prometheus/manifests/ -f kube-prometheus/manifests/setup
}
