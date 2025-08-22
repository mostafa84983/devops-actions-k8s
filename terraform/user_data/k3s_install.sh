#!/bin/bash
PUBLIC_IP=$(curl -s http://169.254.169.254/latest/meta-data/public-ipv4)

curl -sfL https://get.k3s.io | INSTALL_K3S_EXEC="server --tls-san $PUBLIC_IP --write-kubeconfig-mode 644" sh -
