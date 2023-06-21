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
    if [ "$2" == *"$SUB"* ]; then echo $2; else try_gem; fi
}

try_gem() {
    gem install $gem
    l=`gem spec $gem homepage | cut -d " " -f 2`
    SUB="http"
    if [ "$l" == *"$SUB"* ]; then echo $l; else echo "UNKOWN"; fi
}

l=`curl -s https://rubygems.org/gems/$gem | grep -A 2 'License:' | grep '<p>' | cut -d "<" -f 2 | cut -c3-`


if [ -z $l ]; then 
    try_github
else 
    echo $l
fi