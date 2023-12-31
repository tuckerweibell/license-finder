#!/bin/bash
. 'license-finder/spinner.sh'

handle_yarn () {
    if [ $YARN == "y" ]; then
        start_spinner "Processing yarn packages..."
        yarn licenses --ignore-engines list --json --no-progress | jq > license-finder/dependencies/yarn_deps.json
        stop_spinner 0
    fi
}