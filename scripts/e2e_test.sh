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
  # Change directory to ./scripts
  cd $(dirname "$0")
  ./deploy_api.sh
  ./deploy_app.sh
  response=$(./query_api.sh BOS quiet)
  if [[ "$response" != "General Edward Lawrence Logan International Airport" ]]; then
    exit 1
  fi
}

main "$@"
