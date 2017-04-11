# Copyright 2017 Google Inc. All Rights Reserved.
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#     http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.

# Airport data provided by David Megginson (http://ourairports.com/data/).

import csv
import io

class Airports(object):
  """An interface for reading data about airports."""

  def __init__(self):
    with open('third_party/airports.csv', 'r') as f:
      self.airport_file = io.StringIO(f.read())
      self.airport_reader = csv.DictReader(self.airport_file)

  def get_airport_by_iata(self, iata_code):
    """Given an IATA code, look up that airport's name.

    Args:
      iata_code: (string) The IATA code of the airport to find.

    Returns:
      string: The airport name, if found.
      None: The airport was not found.
    """
    self.airport_file.seek(0)
    for row in self.airport_reader:
      if row['iata_code'] == iata_code:
        return row['name']
    return None
