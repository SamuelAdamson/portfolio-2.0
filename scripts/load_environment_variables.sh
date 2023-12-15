#!/bin/bash

# Run with `source load_environment_variables.sh <sourec_directory>`

# The purpose of this script is to load environment variables from a .env file
# in development environments. In Python Google Cloud Functions, environment
# variables are accessed using `os.environ.get()`. Thus, we are storing 
# environment variables in the same way.

load_env_file() {
    env_file="$1"
    if [ -f "$env_file" ]; then
        while IFS= read -r line; do
            export "$line"
        done < "$env_file"
        echo "Environment variables loaded from $env_file"
    fi
}

if [ "$#" -ne 1 ]; then
    echo "Usage: source $0 <source_directory>"
    exit 1
fi

dir="$1"

# recursively search all directories
for dir in $(find ${dir} -maxdepth 5 -type d -not -path **/.git*); do
    if [ -f "${dir}/.env" ]; then
        load_env_file "${dir}/.env"
    fi
done
