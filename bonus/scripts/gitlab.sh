# Récupérer le mot de passe GitLab en spécifiant le certificat CA pour éviter l'erreur TLS
echo "===== GitLab Access Information ====="
echo "URL: http://gitlab.hosts.local/"
echo "Username: root"
PASSWORD=$(kubectl --certificate-authority=$(pwd)/ca.crt get secret -n gitlab gitlab-initial-root-password -o jsonpath="{.data.password}" | base64 --decode)
echo "Password: ${PASSWORD}"
echo "===================================="

# Get certificat
openssl s_client -showcerts -connect gitlab.hosts.local:443 </dev/null 2>/dev/null | openssl x509 -outform PEM > gitlab.crt