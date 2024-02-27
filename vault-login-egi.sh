#! /bin/bash

#
# Sign-in to Hashicorp Vault using EGI AAI and OIDC agent
#

VAULT_TOKEN="$(vault write auth/jwt/login jwt="$(oidc-token egi)" | grep -Po 'token\s+\K[^\s]+$')"
VAULT_HOME=/secrets/users/$(curl -X POST https://aai.egi.eu/auth/realms/egi/protocol/openid-connect/userinfo -H "Authorization: Bearer $(oidc-token egi)" | jq -r .sub)
export VAULT_TOKEN VAULT_HOME
