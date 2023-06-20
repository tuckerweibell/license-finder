#!/bin/bash

. 'licnese-finder/spinner.sh'

handle_gem() {
    if [ $RUBY == "y" ]; then
        start_spinner "Processing gems..."
        echo "{\"dependencies\": [" > license-finder/dependencies/gem_deps.json && gem list | \
            cut -d " " -f1 | \
            xargs -t -I {} bash -c 'homepage=`gem spec {} homepage | \
                                    cut -c5-` && version=`gem spec {} version | \
                                    tail -n2 | cut -d " " -f 2` && name=`gem spec {} name | \
                                    cut -c5-` && license=`gem spec {} licenses | xargs | \
                                    cut -c7-` && if ([ $license = "[]" ] || \ 
                                    [ -v $license ] || [ -z $license ] || \
                                    [ $license = "" ]) && ! [ -z $name ]; then \
                                    echo "{\"name\":\"$name\",\"version\":\"$version\",\"license\":\"UNKOWN\",\"homepage_url\":\"$homepage\"}" | \
                                    jq && echo ,; else if ! [$name == ""]; then \
                                    echo "{\"name\":\"$name\",\"version\":\"$version\",\"license\":\"$license\",\"homepage_url\":\"$homepage\"}" | \
                                    jq && echo ,; fi; fi' 2>/dev/null >> license-finder/dependencies/gem_deps.json && sed -i '$ d' license-finder/dependencies/gem_deps.json && echo "]}" >> license-finder/dependencies/gem_deps.json
        stop_spinner
    fi
}