#!/bin/bash

handle_npm() {
    if [ $NPM == "y" ]; then
            npm install -g license-checker && license-checker --json | jq > license-finder/dependencies/npm_deps.json
    fi
}