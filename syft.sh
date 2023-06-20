#!/bin/bash

syft () {
    syft packages . -o spdx-json > syft.json
}