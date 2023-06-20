#!/bin/bash

detect_os () {
    OS=`cat /etc/os-release | grep -w ID | cut -d "=" -f 2`
    if ! ([ $OS == "debian" ] || [ $OS == "alpine" ]); then prompt_os; fi
}

prompt_os () {
        printf '\n'; echo 'Please select OS:'; echo '----------------'; printf '\n' 
        echo '1) alpine' ; echo '2) debian'; printf '\n'; read -p 'Enter: ' OS
    fi
}
