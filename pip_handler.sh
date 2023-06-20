#!/bin/bash

handle_pip() {
    if [ $PIP == "y" ]; then
        pip install -U pip-licenses
        pip-licenses -u --format=json > license-finder/dependencies/python_deps.json
    fi
}