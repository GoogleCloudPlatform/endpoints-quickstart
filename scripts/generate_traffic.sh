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
  # Get our working project, or exit if it's not set.
  local project_id=$(get_project_id)
  if [[ -z "$project_id" ]]; then
    exit 1
  fi
  local url="https://${project_id}.appspot.com/airportName?iataCode=${IATA_CODE}"
  echo "Generating traffic to ${url}..."
  echo "Press Ctrl-C to stop."
  # Run curl as fast as we can (without parallelization).
  while true; do
    curl "$url" &>/dev/null
  done
}

# Defaults.
IATA_CODE="SFO"

if [[ "$#" == 0 ]]; then
  : # Use defaults.
elif [[ "$#" == 1 ]]; then
  IATA_CODE="$1"
else
  echo "Wrong number of arguments specified."
  echo "Usage: generate_traffic.sh [iata-code]"
  exit 1
fi

main "$@"
