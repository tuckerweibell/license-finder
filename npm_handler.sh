#!/bin/bash
. 'license-finder/spinner.sh'

handle_npm() {
    if [ $NPM == "y" ]; then
        start_spinner "Processing npm packages..."
        npm install -g license-checker && license-checker --json | jq > license-finder/dependencies/npm_deps.json
        stop_spinner
    fi
}