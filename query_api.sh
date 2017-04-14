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
  read -p "Please enter a three digit airport code (leave blank for SFO): " IATA_CODE
  if [[ -z "$IATA_CODE" ]]; then
    IATA_CODE="SFO"
  fi
  QUERY="curl \"https://${project_id}.appspot.com/airportName?iataCode=${IATA_CODE}\""
  echo "$QUERY"
  eval $QUERY
  # Our API doesn't print newlines. So we do it ourselves.
  printf '\n'
}

main "$@"
