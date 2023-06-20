#!/bin/bash

install_tools () {
    set_existing
    if [ $OS == "alpine" ]; then alpine; fi
    if [ $OS == "debian" ]; then debian; fi
    install_syft
}

set_existing () {
    if git --version &>/dev/null; then GIT="y"; else GIT="n"; fi
    if jq --version &>/dev/null; then JQ="y"; else JQ="n"; fi
    if ruby --version &>/dev/null; then RUBY="y"; else RUBY="n"; fi
    if curl --version &>/dev/null; then CURL="y"; else CURL="n"; fi
    if yarn --version &>/dev/null; then YARN="y"; else YARN="n"; fi
    if npm --version &>/dev/null; then NPM="y"; else NPM="n"; fi
    if pip --version &>/dev/null; then PIP="y"; else PIP="n"; fi
}

alpine () {
    apk update
    if [ $GIT == "n" ]; then apk add git; GIT_INSTALLED="y"; fi
    if [ $JQ == "n" ]; then apk add jq; JQ_INSTALLED="y"; fi
    if [ $RUBY == "n" ]; then apk add ruby; RUBY_INSTALLED="y"; fi
    if [ $CURL == "n" ]; then apk add curl; CURL_INSTALLED="y"; fi
}

debian () {
    apt-get update -y
    if [ $GIT == "n" ]; then apt install git -y; GIT_INSTALLED="y"; fi
    if [ $JQ == "n" ]; then apt install jq -y; JQ_INSTALLED="y"; fi
    if [ $RUBY == "n" ]; then apt install ruby -y; RUBY_INSTALLED="y"; fi
    if [ $CURL == "n" ]; then apt install curl -y; CURL_INSTALLED="y"; fi
}

install_syft () {
    curl -sSfL https://raw.githubusercontent.com/anchore/syft/main/install.sh | sh -s -- -b /usr/local/bin
}