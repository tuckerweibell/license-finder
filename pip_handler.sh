#!/bin/bash
. 'license-finder/spinner.sh'

handle_pip() {
    if [ $PIP == "y" ]; then
        start_spinner "Processing python packages..."
        pip install -U pip-licenses
        pip-licenses -u --format=json > license-finder/dependencies/python_deps.json
        stop_spinner
    fi
}