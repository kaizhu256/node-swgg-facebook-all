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
    #!! mkdir -p developer.facebook.com/v3/guides
    #!! mkdir -p developer.facebook.com/v3/libraries
    #!! mkdir -p developer.facebook.com/v3/users/emails
    #!! mkdir -p developer.facebook.com/v3/users/followers
    #!! mkdir -p developer.facebook.com/v3/users/keys
    #!! mkdir -p developer.facebook.com/v3/users/gpg_keys
    #!! mkdir -p developer.facebook.com/v3/users/administration
    #!! mkdir -p developer.facebook.com/v3/users/blocking
    wget \
        -U "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_12_6) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/64.0.1234.123 Safari/537.36" \
        -l 2 -m -np -nv \
        https://developers.facebook.com/docs/graph-api/reference/
)}

shNpmScriptPostinstall() {
# this function will do nothing
    return
}

# run command
"$@"
