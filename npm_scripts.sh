#!/bin/sh

shNpmScriptApidocRawCreate() {(set -e
# this function will create the raw apidoc
    find tmp/apidoc.raw/developer.facebook.com/v3 -name index.html | \
        sed -e 's|/index.html||' | \
        sort | sed -e 's|$|/index.html|' | \
        xargs -I @ -n 1 sh -c 'printf "\\n@\\n" && cat @' | \
        sed -e 's| *$||' > \
        .apidoc.raw.html
)}

shNpmScriptApidocRawFetch() {(set -e
# this function will fetch the raw apidoc
    mkdir -p tmp/apidoc.raw
    cd tmp/apidoc.raw
    rm -fr developer.facebook.com
    wget \
        -U "Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) \
Chrome/64.0.1234.123 Safari/537.36" \
        -l 2 -np -nv -r \
        https://developers.facebook.com/docs/graph-api/reference/
    #!! find developers.facebook.com/docs/graph-api/reference -type f | \
    #!! sed -e '|\(<\/\w*>\)||'

    #!! grep '\.1\|index.html'
    find . -name *.1 | \
    grep -v '.1/' | \
    sed -e 's|\(.*\)\.1|cp \1.1 \1/index.html|' | \
    xargs -n 1 sh -c
)}

shNpmScriptPostinstall() {
# this function will do nothing
    return
}

# run command
"$@"
