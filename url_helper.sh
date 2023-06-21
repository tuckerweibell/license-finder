#!/bin/bash

gem=$1
old=$2


url=`grep $gem temp.txt | cut -d " " -f3`

if echo $url | grep "http" &>/dev/null; then echo $url; else echo $2; fi