/* istanbul instrument in package swgg_facebook */
/*jslint
  bitwise: true,
  browser: true,
  indent: 2,
  maxerr: 8,
  maxlen: 96,
  node: true,
  nomen: true,
  regexp: true,
  stupid: true
*/
(function () {
  'use strict';
  var local;



  // run shared js-env code - init-before
  (function () {
    // init local
    local = {};
    // init modeJs
    local.modeJs = (function () {
      try {
        return typeof navigator.userAgent === 'string' &&
          typeof document.querySelector('body') === 'object' &&
          typeof XMLHttpRequest.prototype.open === 'function' &&
          'browser';
      } catch (errorCaughtBrowser) {
        return module.exports &&
          typeof process.versions.node === 'string' &&
          typeof require('http').createServer === 'function' &&
          'node';
      }
    }());
    // init global
    local.global = local.modeJs === 'browser'
      ? window
      : global;
    // init utility2_rollup
    local = local.global.utility2_rollup || local;
    // init lib
    local.local = local.swgg_facebook = local;
    // init exports
    if (local.modeJs === 'browser') {
      local.global.utility2_swgg_facebook = local;
    } else {
      // require builtins
      Object.keys(process.binding('natives')).forEach(function (key) {
        if (!local[key] && !(/\/|^_|^sys$/).test(key)) {
          local[key] = require(key);
        }
      });
      module.exports = local;
      module.exports.__dirname = __dirname;
      module.exports.module = module;
      module.exports = local.global.utility2_rollup ||
        require('./assets.utility2.rollup.js');
    }
  }());
}());