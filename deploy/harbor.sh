#!/bin/bash

function install() {
    echo "Installing harbor..."
    # Configure the Helm repository
    helm repo add harbor https://helm.goharbor.io
    helm repo update
    helm install harbor harbor/harbor

}

function uninstall() {
    echo "Uninstalling harbor..."
    hele uninstall harbor
}
