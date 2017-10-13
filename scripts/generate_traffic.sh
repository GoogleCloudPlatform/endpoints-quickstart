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

set -euo pipefail

source util.sh

# Use this to keep track of what HTTP status codes we receive.
declare -A codes

# generate_traffic will print a status update every UPDATE_FREQUENCY messages.
UPDATE_FREQUENCY=25

main() {
  # Get our working project, or exit if it's not set.
  local project_id=$(get_project_id)
  if [[ -z "$project_id" ]]; then
    exit 1
  fi
  export url="https://${project_id}.appspot.com/airportName?iataCode=${IATA_CODE}"
  echo "This command will exit automatically in $TIMEOUT_SECONDS seconds."
  echo "Generating traffic to ${url}..."
  echo "Press Ctrl-C to stop."
  local endtime=$(($(date +%s) + $TIMEOUT_SECONDS))
  local request_count=0
  # Send queries repeatedly until TIMEOUT_SECONDS seconds have elapsed.
  while [[ $(date +%s) -lt $endtime ]]; do
    request_count=$(( request_count + 1))
    if [[ $((request_count % UPDATE_FREQUENCY)) == 0 ]]; then
      echo "Served ${request_count} requests."
    fi
    # Make the HTTP request and save its status in an associative array.
    http_status=$(curl -so /dev/null -w "%{http_code}" "$url")
    if [[ "${!codes[@]}" != *"$http_status"* ]]; then
      codes["$http_status"]="1"
    else
      codes["$http_status"]="$(( ${codes[$http_status]} + 1 ))"
    fi
  done
}

print_status() {
  echo ""
  echo "HTTP status codes received from ${url}:"
  for code in "${!codes[@]}"; do
    echo "${code}: ${codes[$code]}"
  done
}

# Defaults.
IATA_CODE="SFO"
TIMEOUT_SECONDS=$((5 * 60)) # Timeout after 5 minutes.

if [[ "$#" == 0 ]]; then
  : # Use defaults.
elif [[ "$#" == 1 ]]; then
  IATA_CODE="$1"
else
  echo "Wrong number of arguments specified."
  echo "Usage: generate_traffic.sh [iata-code]"
  exit 1
fi

# Print the received codes when we exit.
trap print_status EXIT

main "$@"
