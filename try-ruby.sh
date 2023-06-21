#!/bin/bash

gem=$1

try_github() {
    l=`curl -s https://rubygems.org/gems/$gem | grep "Source Code" | cut -d '"' -f 8`
    if [ -z $l ]; then 
        try_url
    else 
        l=`curl -s -L $l | grep -A10 License | grep -m1 " license" | cut -d " " -f 6`
        if [ -z $l ]; then echo $l; else echo "UNKOWN"; fi
    fi
}

try_url() {
    SUB="http"
    if echo $2 | grep "http" &>/dev/null; then echo $2; else try_gem; fi
}

try_gem() {
    if echo $gem | grep "ez" &>/dev/null; then 
        l="EZCATER REPO - UNLICENSED"
        echo $l
    else
        gem install $gem &>/dev/null
        l=`gem spec $gem homepage 2>/dev/null | cut -d " " -f2`
        echo $gem
        echo $l
        if echo $l | grep "http" &>/dev/null; then
            l=`curl -s -L $l | grep -A10 License | grep -m1 " license" | cut -d " " -f 6`
            if [ -z $l ]; then echo $l; else echo "UNKOWN"; fi
        fi
    fi
}

l=`curl -s https://rubygems.org/gems/$gem | grep -A 2 'License:' | grep '<p>' | cut -d "<" -f 2 | cut -c3-`


if [ -z $l ]; then 
    try_github
else 
    echo $l
fi