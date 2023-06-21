#!/bin/bash

. 'license-finder/scripts.sh'

# Get operating system
detect_os

# Install required tools as needed
install_tools

# Get base sbom with syft
start_syft

# Handler checklist
handle_yarn
handle_npm
handle_pip
handle_gem


