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

check_devshell() {
  if [[ -z "$DEVSHELL_PROJECT_ID" ]]; then
    echo "Environment variable DEVSHELL_PROJECT_ID is not set."
    echo "Please set it to your project ID and try again."
    exit 1
  fi
}

prompt() {
  # Prompts the user to enter "yes" or "no".
  # If they enter "yes", then $1 is executed as a command.
  if [[ -z "$1" ]]; then
    echo "Error: no command specified for prompt. Exiting."
    exit 1
  fi
  while true; do
    read -p "Shall I proceed? " prompt
    case "$prompt" in
      [Yy]* )
        # Not quoted because this should be interpreted as multiple tokens.
        $1
        break
        ;;
      [Nn]* )
        echo "Not continuing."
        exit 1
        ;;
      * )
        echo "Please enter yes or no."
        ;;
    esac
  done
}
