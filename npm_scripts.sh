#!/bin/sh

shNpmScriptApidocRawCreate() {(set -e
# this function will create the raw apidoc
    find tmp/developer.facebook.com/v3 -name index.html | \
        sed -e 's|/index.html||' | \
        sort | sed -e 's|$|/index.html|' | \
        xargs -I @ -n 1 sh -c 'printf "\\n@\\n" && cat @' | \
        sed -e 's| *$||' > \
        .apidoc.raw.html
)}

shNpmScriptApidocRawFetch() {(set -e
# this function will fetch the raw apidoc
    mkdir -p tmp
    cd tmp
    rm -fr developer.facebook.com
    wget \
        -U "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_12_6) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/64.0.1234.123 Safari/537.36" \
        -l 2 -np -nv -r \
        https://developers.facebook.com/docs/graph-api/reference/index.html
)}

shNpmScriptPostinstall() {
# this function will do nothing
    return
}

# run command
"$@"
