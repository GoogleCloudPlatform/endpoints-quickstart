#!/bin/bash

if [[ "$#" != 1 ]]; then
  echo "Usage: e2e_test.sh project-id"
  exit 1
fi

set -xeuo pipefail
PROJECT_ID="$1"

main() {
  # There's no good reason this should be set. But unset it anyways.
  unset DEVSHELL_PROJECT_ID
  gcloud config set project "$PROJECT_ID"
  ./deploy_api.sh
  ./deploy_app.sh
  response=$(./query_api.sh BOS quiet)
  if [[ "$response" != "General Edward Lawrence Logan International Airport" ]]; then
    exit 1
  fi
}

main "$@"
