#!/bin/bash

source util.sh

main() {
  check_devshell
  local temp_file=$(mktemp --suffix=".yaml")
  cat "${API_FILE}" | sed -E "s/YOUR-PROJECT-ID/${DEVSHELL_PROJECT_ID}/g" > "$temp_file"
  echo "Deploying $API_FILE..."
  gcloud service-management deploy "$temp_file"
  rm "$temp_file"
}

if [[ -z "$1" ]]; then
  API_FILE="openapi.yaml"
else
  API_FILE="$1"
fi
main "$@"
