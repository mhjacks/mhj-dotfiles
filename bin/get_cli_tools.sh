#!/bin/bash

# oc
# https://access.redhat.com/downloads/content/290/ver=4.9/rhel---8/4.9.10/x86_64/packages

# ArgoCD
sudo curl -sSL -o /usr/local/bin/argocd https://github.com/argoproj/argo-cd/releases/latest/download/argocd-linux-amd64 && sudo chmod +x /usr/local/bin/argocd

# tkn
sudo dnf install https://github.com/tektoncd/cli/releases/download/v0.21.0/tektoncd-cli-0.21.0_Linux-64bit.rpm

# helm
curl https://raw.githubusercontent.com/helm/helm/main/scripts/get-helm-3 | sudo bash

# yq
sudo curl -sSL -o /usr/local/bin/yq https://github.com/mikefarah/yq/releases/download/v4.16.1/yq_linux_amd64 && \
	sudo chmod 755 /usr/local/bin/yq

