#!/bin/bash
set -euo pipefail

NAMESPACE="invoice-ninja"

# Check required env vars
# Generate APP_KEY with:
#   docker run --rm invoiceninja/invoiceninja php artisan key:generate --show
: "${APP_KEY:?Set APP_KEY (generate with: docker run --rm invoiceninja/invoiceninja php artisan key:generate --show)}"
: "${DB_PASSWORD:?Set DB_PASSWORD}"
: "${IN_USER_EMAIL:?Set IN_USER_EMAIL}"
: "${IN_PASSWORD:?Set IN_PASSWORD}"

kubectl create namespace "$NAMESPACE" --dry-run=client -o yaml | kubectl apply -f -

kubectl create secret generic invoice-ninja-secrets \
  --namespace="$NAMESPACE" \
  --from-literal=APP_KEY="$APP_KEY" \
  --from-literal=DB_PASSWORD="$DB_PASSWORD" \
  --from-literal=MYSQL_ROOT_PASSWORD="$DB_PASSWORD" \
  --from-literal=MYSQL_DATABASE="ninja" \
  --from-literal=MYSQL_USER="ninja" \
  --from-literal=MYSQL_PASSWORD="$DB_PASSWORD" \
  --from-literal=IN_USER_EMAIL="$IN_USER_EMAIL" \
  --from-literal=IN_PASSWORD="$IN_PASSWORD" \
  --dry-run=client -o yaml | kubectl apply -f -

echo "Secret invoice-ninja-secrets created in namespace $NAMESPACE"
