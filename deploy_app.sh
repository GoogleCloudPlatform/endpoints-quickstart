#!/bin/bash
# Copyright 2017 Google Inc. All Rights Reserved.
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#    http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.

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
