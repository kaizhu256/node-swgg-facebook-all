#!/bin/sh

shNpmScriptApidocRawCreate() {(set -e
# this function will create the raw apidoc
    cd tmp/apidoc.raw
    find developers.facebook.com/docs/graph-api/reference -type f | \
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
    local.fs.readFile(file1, "utf8", function (error, data) {
        file2 = (file1 + "/index.html")
            .replace((/\/index.html\/|\.1\/index.html/), "/")
            .replace("//", "/");
        if (!(/\/index.html$/).test(file2) ||
                ((/\w\.1$/).test(file1) && local.fs.existsSync(file2))) {
            local.fs.unlink(file1, local.onErrorDefault);
            return;
        }
        local.assert(!error, error);
        if (file1 !== file2) {
            local.fs.unlink(file1, local.onErrorDefault);
        }
        data = data
            .split("<div id=\"documentation_body_pagelet\"").slice(-1)[0]
            .split("<script>")[0];
        local.assert(data.indexOf("<script") < 0);
        local.fs.mkdir(local.path.dirname(file2), function () {
            local.fs.writeFile(file2, data, local.onErrorDefault);
        });
    });
});
// </script>
        '
)}

shNpmScriptApidocRawFetch() {(set -e
# this function will fetch the raw apidoc
    mkdir -p tmp/apidoc.raw
    cd tmp/apidoc.raw
    if [ ! "$npm_config_mode_no_wget" ]
    then
        rm -fr developers.facebook.com
        wget \
            --default-page=index.html \
            -U "Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) \
    Chrome/64.0.1234.123 Safari/537.36" \
            -l 2 -nc -np -nv -r \
            https://developers.facebook.com/docs/graph-api/reference/ 2>&1 | \
        tee wget.log
    fi
    find developers.facebook.com/docs/graph-api/reference -name *.1 -type f | \
        xargs -n 100 rm
    find developers.facebook.com/docs/graph-api/reference -type f | \
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
process.argv.slice(1).forEach(function (file1, ii, file2, options) {
    options = {};
    local.onNext(options, function (error) {
        switch (options.modeNext) {
        case 1:
            file2 = (file1 + "/index.html").replace("/index.html/", "/");
            if (file1 === file2) {
                return;
            }
            console.error("rename " + file1 + " -> " + file2);
            local.fs.rename(file1, "/tmp/rename." + ii, options.onNext);
            break;
        case 2:
            local.fs.mkdir(local.path.dirname(file2), options.onNext);
            break;
        case 3:
            local.fs.rename("/tmp/rename." + ii, file2, options.onNext);
            break;
        default:
            local.assert(!error, error);
        }
    });
    options.modeNext = 0;
    options.onNext();
});
// </script>
        '
    #!! find developers.facebook.com/docs/graph-api/reference -type f | \
        #!! xargs -n 100 node -e '
#!! // <1script>
#!! /*jslint
    #!! bitwise: true,
    #!! browser: true,
    #!! maxerr: 8,
    #!! maxlen: 100,
    #!! node: true,
    #!! nomen: true,
    #!! regexp: true,
    #!! stupid: true
#!! */
#!! "use strict";
#!! var local;
#!! local = require("../../assets.utility2.rollup.js");
#!! process.argv.slice(1).forEach(function (file1, ii, file2, options) {
    #!! options = {};
    #!! local.onNext(options, function (error, data) {
        #!! switch (options.modeNext) {
        #!! case 1:
            #!! local.fs.readFile(file1, "utf8", options.onNext);
            #!! break;
        #!! case 2:
            #!! options.data = data;
            #!! file2 = (file1 + "/index.html").replace("/index.html/", "/");
            #!! if (file1 === file2) {
                #!! return;
            #!! }
            #!! console.error("rename " + file1 + " -> " + file2);
            #!! local.fs.unlink(file1, options.onNext);
            #!! break;
        #!! case 3:
            #!! local.fs.mkdir(local.path.dirname(file2), options.onNext);
            #!! break;
        #!! case 4:
            #!! local.fs.rename(file1, file2, options.onNext);
            #!! break;
        #!! default:
            #!! local.assert(!error, error);
        #!! }
    #!! });
    #!! options.modeNext = 0;
    #!! options.onNext();
#!! });
#!! // </script>
        #!! '
)}

shNpmScriptPostinstall() {
# this function will do nothing
    return
}

# run command
"$@"
