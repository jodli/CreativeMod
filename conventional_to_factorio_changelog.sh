#!/bin/bash

while IFS= read -r line; do
  if [[ "$line" =~ ^##\ \[(.*)\] ]]; then
    # Extract the version from the input
    version="${BASH_REMATCH[1]}"
    # Get the date
    date=$(date +%Y-%m-%d)

    # Print the separator, version, and date
    echo "---------------------------------------------------------------------------------------------------"
    echo "Version: $version"
    echo "Date: $date"
  elif [[ "$line" =~ ^###\ (.*)$ ]]; then
    current_type="${BASH_REMATCH[1]}"
    echo "  $current_type:"
  elif [[ "$line" =~ ^\*\ (.*)\ \(.*\)$ ]]; then
    message="${BASH_REMATCH[1]}"
    echo "    - $message"
  fi
done