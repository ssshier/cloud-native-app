#!/bin/bash

function install() {
    echo "Installing traefik..."
    # Configure the Helm repository
    helm repo add traefik https://helm.traefik.io/traefik
    helm repo update
    helm install traefik traefik/traefik

}

function uninstall() {
    echo "Uninstalling traefik..."
    hele uninstall traefik
}
