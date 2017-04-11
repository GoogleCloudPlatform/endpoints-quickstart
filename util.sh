#!/bin/bash

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
