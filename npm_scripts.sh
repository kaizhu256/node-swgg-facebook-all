#!/bin/sh

shNpmScriptApidocRawCreate() {(set -e
# this function will create the raw apidoc
    cd tmp/apidoc.raw
    find developers.facebook.com -type f | \
        xargs -n 100 node -e '
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
var local;
local = require("../../assets.utility2.rollup.js");
process.argv.slice(1).forEach(function (file1, file2) {
    file2 = (file1 + "/index.html")
        .replace((/\/index.html\/|\.1\/index.html/), "/")
        .replace('//', '/');
    if (!(/\/index.html$/).test(file2) ||
            ((/\w\.1$/).test(file1) && local.fs.existsSync(file2))) {
        local.fs.unlink(file1, local.onErrorDefault);
        return;
    }
    local.fs.mkdir(local.path.dirname(file2), local.nop);
    local.fs.readFile(file1, "utf8", function (error, data) {
        local.assert(!error, error);
        if (file1 !== file2) {
            local.fs.unlink(file1, local.onErrorDefault);
        }
        data = data
            .replace((/(<script\b[\S\s]*?<\/script>)/g), "")
            .replace((/(<\/\w+>)/g), "$1\n")
            .replace((/(<\/\w+>)\n{2,}/g), "$1\n");
        local.fs.writeFile(file2, data, local.onErrorDefault);
    });
});
// </script>
        '
)}

shNpmScriptApidocRawFetch() {(set -e
# this function will fetch the raw apidoc
    mkdir -p tmp/apidoc.raw
    cd tmp/apidoc.raw
    rm -fr developers.facebook.com
    wget \
        --default-page=index.html \
        -U "Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) \
Chrome/64.0.1234.123 Safari/537.36" \
        -l 2 -nc -np -nv -r \
        https://developers.facebook.com/docs/graph-api/reference/ 2>&1 | \
    tee wget.log
)}

shNpmScriptPostinstall() {
# this function will do nothing
    return
}

# run command
"$@"
