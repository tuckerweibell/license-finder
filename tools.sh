#!/bin/bash

install_tools () {
    set_existing
}

set_existing () {
    if git --version &>/dev/null; then GIT="y"; else GIT="n"; fi
    echo $GIT
}