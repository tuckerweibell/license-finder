#!/bin/bash

start_syft () {
    syft packages . -o spdx-json > syft.json
}