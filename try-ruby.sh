#!/bin/bash

gem=$1

try_github() {
    l=`curl -s https://rubygems.org/gems/$gem | grep "Source Code" | cut -d '"' -f 8`
    if [ -z $l ]; then 
        try_url
    else 
        echo $l 
    fi
}
#gem spec capybara_discoball homepage | cut -d " " -f 2
try_url() {
    SUB="http"
    if echo $2 | grep "http"; then echo $2; else try_gem; fi
}

try_gem() {
    if echo $gem | grep "ez"; then 
        l="EZCATER REPO - UNLICENSED"
        echo $l
    else
        gem install $gem &>/dev/null
        l=`gem spec $gem homepage 2>/dev/null | cut -d " " -f2`
        if echo $2 | grep "http"; then echo $l; else echo "UNKOWN"; fi
    fi
}

l=`curl -s https://rubygems.org/gems/$gem | grep -A 2 'License:' | grep '<p>' | cut -d "<" -f 2 | cut -c3-`


if [ -z $l ]; then 
    try_github
else 
    echo $l
fi