#!/bin/sh

shNpmScriptApidocRawCreate() {(set -e
# this function will create the raw apidoc
    find tmp/developer.github.com/v3 -name index.html | \
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
    rm -fr developer.github.com
    mkdir -p developer.github.com/v3/guides
    mkdir -p developer.github.com/v3/libraries
    mkdir -p developer.github.com/v3/users/emails
    mkdir -p developer.github.com/v3/users/followers
    mkdir -p developer.github.com/v3/users/keys
    mkdir -p developer.github.com/v3/users/gpg_keys
    mkdir -p developer.github.com/v3/users/administration
    mkdir -p developer.github.com/v3/users/blocking
    wget -l 1 -np -nv -r https://developer.github.com/v3/index.html
)}

shNpmScriptPostinstall() {
# this function will do nothing
    return
}

# run command
"$@"
