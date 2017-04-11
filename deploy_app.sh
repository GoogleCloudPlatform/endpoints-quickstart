#!/bin/bash

source util.sh
APP="app.yaml"
APP_DIRECTORY="./app"

main() {
  check_devshell
  gcloud app create
  cd "$APP_DIRECTORY"
  local service_name="${API_NAME}.endpoints.${DEVSHELL_PROJECT_ID}.cloud.goog"
  # Get the latest config_id of your service.
  local config_id=$(gcloud service-management configs list \
    --service="$service_name" \
    --sort-by="~config_id" --limit=1 --format="value(CONFIG_ID)" \
    | tr -d '[:space:]')
  cat "$APP_TEMPLATE" \
    | sed -E "s/SERVICE_NAME/${service_name}/g" \
    | sed -E "s/SERVICE_CONFIG_ID/${config_id}/g" \
    > "$APP"
  echo "created $APP"
  echo "Deploying ${APP_TEMPLATE}..."
  gcloud app deploy
  rm "$APP"
}

if [[ -z "$1" ]]; then
  APP_TEMPLATE="app_template.yaml"
else
  APP_TEMPLATE="$1"
fi

main "$@"
