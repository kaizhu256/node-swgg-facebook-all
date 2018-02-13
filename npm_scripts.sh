#!/bin/sh

shNpmScriptApidocRawCreate() {(set -e
# this function will create the raw apidoc
    cd tmp/apidoc.raw
    find developers.facebook.com -type f | \
        grep -ve "index.html\>" | \
        xargs -n 1 rm
    find developers.facebook.com -type f | \
        grep -e "?" | \
        xargs -n 1 rm
    find developers.facebook.com -type f | \
        xargs -n 1 node -e '
// <script>
/*jslint
    bitwise: true,
    browser: true,
    maxerr: 8,
    maxlen: 100,
    node: true,
    nomen: true,
    regexp: true,
    stupid: true
*/
"use strict";
if (!(/\/index.html$/).test(process.argv[1])) {
    require("fs").unlinkSync(process.argv[1]);
} else {
    require("fs").writeFileSync(
        process.argv[1],
        require("fs").readFileSync(process.argv[1], "utf8")
            .replace((/(<script\b[\S\s]*?<\/script>)/g), "")
            .replace((/(<\/\w+>)/g), "$1\n")
            .replace((/(<\/\w+>)\n{2,}/g), "$1\n")
    );
}
// </script>
        '
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
)}

shNpmScriptPostinstall() {
# this function will do nothing
    return
}

# run command
"$@"
