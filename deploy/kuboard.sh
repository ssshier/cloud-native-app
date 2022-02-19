#!/bin/bash

function install() {
    echo "Installing kuboard..."
    kubectl apply -f https://addons.kuboard.cn/kuboard/kuboard-v3.yaml
}

function uninstall() {
    echo "Uninstalling kuboard..."
    kubectl delete --ignore-not-found -f https://addons.kuboard.cn/kuboard/kuboard-v3.yaml
}
