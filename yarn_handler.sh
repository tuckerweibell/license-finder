#!/bin/bash

handle_yarn () {
    if [ $YARN == "y" ]; then
        yarn licenses --ignore-engines list --json --no-progress | jq > license-finder/dependencies/yarn_deps.json
    fi
}