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

API_NAME="airports-api"

get_project_id() {
  # Find the project ID first by DEVSHELL_PROJECT_ID (in Cloud Shell)
  # and then by querying the gcloud default project.
  local project=""
  if [[ -n "$DEVSHELL_PROJECT_ID" ]]; then
    project="$DEVSHELL_PROJECT_ID"
  else
    project=$(gcloud config get-value project 2> /dev/null)
  fi
  if [[ -z "$project" ]]; then
    >&2 echo "DEVSHELL_PROJECT_ID is not set and no default project was found."
    >&2 echo "Please use the Cloud Shell or set your default project by typing:"
    >&2 echo "gcloud config set project YOUR-PROJECT-NAME"
  fi
  echo "$project"
}

check_devshell() {
  if [[ -z "$DEVSHELL_PROJECT_ID" ]]; then
    echo "Environment variable DEVSHELL_PROJECT_ID is not set."
    echo "Please set it to your project ID and try again."
    exit 1
  fi
}
