#!/bin/bash

# This script makes all public repositories private for a range of organizations.
# It iterates through organizations c1fijinetworks through c20fijinetworks.

# Set the start and end numbers for the loop
START=1
END=20

echo "Starting the process to make repositories private..."
echo "----------------------------------------------------"

for i in $(seq $START $END)
do
  # Construct the organization name
  ORG_NAME="c${i}fijinetworks"

  echo ""
  echo ">>> Processing organization: $ORG_NAME"

  # Find all public repos in the organization and make them private
  # The `gh repo list` command will fail gracefully if the org doesn't exist,
  # and the script will simply continue to the next one.
  gh repo list "$ORG_NAME" --public --limit 1000 --json nameWithOwner | \
  jq -r '.[].nameWithOwner' | \
  while read repo; do
    if [ -n "$repo" ]; then
      echo "  -> Making repository '$repo' private..."
      gh repo edit "$repo" --visibility private
    fi
  done

  echo ">>> Finished processing $ORG_NAME."
done

echo ""
echo "----------------------------------------------------"
echo "All organizations have been processed."
