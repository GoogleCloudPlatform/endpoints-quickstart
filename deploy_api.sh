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

main() {
  local project_id=$(get_project_id)
  if [[ -z "$project_id" ]]; then
    exit 1
  fi
  local temp_file=$(mktemp --suffix=".yaml")
  cat "${API_FILE}" | sed -E "s/YOUR-PROJECT-ID/${project_id}/g" > "$temp_file"
  echo "Deploying $API_FILE..."
  gcloud service-management deploy "$temp_file"
  rm "$temp_file"
}

API_FILE="openapi.yaml"
if [[ "$#" == 0 ]]; then
  : # Use defaults.
elif [[ "$#" == 1 ]]; then
  API_FILE="$1"
else
  echo "Wrong number of arguments specified."
  echo "Usage: deploy_api.sh [api-file]"
  exit 1
fi

main "$@"
