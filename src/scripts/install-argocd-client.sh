set +e

if command -v argocd &> /dev/null; then
    echo "argocd is already installed"
    exit 0
fi

BINARY_URL="https://github.com/argoproj/argo-cd/releases/download/$ARGO_CLI_VERSION/argocd-linux-amd64"

curl -sSL -o argocd-linux-amd64 "${BINARY_URL}"
sudo install -m 555 argocd-linux-amd64 /usr/local/bin/argocd
rm argocd-linux-amd64
