JsLogger = (function() {
  var loggerUrl = "/js/logger";

  var getStackTrace = (function () {

    var mode;
    try {(0)();} catch (e) {
      mode = e.stack ? 'Firefox' : window.opera ? 'Opera' : 'Other';
    }

    switch (mode) {
      case 'Firefox' : return function () {
        try {(0)();} catch (e) {
          return e.stack.replace(/^.*?\n/,'').
          replace(/(?:\n@:0)?\s+$/m,'').
          replace(/^\(/gm,'{anonymous}(').
          split("\n");
        }
      };

      case 'Opera' : return function () {
        try {(0)();} catch (e) {
          var lines = e.message.split("\n"),
          ANON = '{anonymous}',
          lineRE = /Line\s+(\d+).*?in\s+(http\S+)(?:.*?in\s+function\s+(\S+))?/i,
          i,j,len;

          for (i=4,j=0,len=lines.length; i<len; i+=2) {
            if (lineRE.test(lines[i])) {
              ++j;
              lines[j] = (RegExp.$3 ?
              RegExp.$3 + '()@' + RegExp.$2 + RegExp.$1 :
              ANON + RegExp.$2 + ':' + RegExp.$1) +
              ' -- ' + lines[i+1].replace(/^\s+/,'');
            }
          }

          lines.splice(j,lines.length-j);
          return lines;
        }
      };

      default : return function () {
        var curr  = arguments.callee.caller,
        FUNC  = 'function', ANON = "{anonymous}",
        fnRE  = /function\s*([\w\-$]+)?\s*\(/i,
        stack = [],j=0,
        fn,args,i;

        while (curr) {
          fn    = fnRE.test(curr.toString()) ? RegExp.$1 || ANON : ANON;
          args  = stack.slice.call(curr.arguments);
          i     = args.length;

          while (i) {
            i--;
            switch (typeof args[i]) {
              case 'string'  : args[i] = '"'+args[i].replace(/"/g,'\\"')+'"'; break;
              case 'function': args[i] = FUNC; break;
            }
          }

          j++;
          stack[j] = fn + '(' + args.join() + ')';
          curr = curr.caller;
        }

        return stack;
      };
    };
  })();

  /**
   * logs a message to the server
   */
  var _log = function(message, url, line) {
    var stack = getStackTrace().slice(0, 3);

    var parameters = "?message=" + encodeURI(message) +
    "&url=" + encodeURI(url) +
    "&line=" + encodeURI(line) +
    "&parent_url=" + encodeURI(document.location.href) +
    "&user_agent=" + encodeURI(navigator.userAgent) +
    "&backtrace=" + encodeURI(stack.join("\n"));

    /** Send error to server */
    new Image().src = loggerUrl + parameters;
  };


  return {
    errorHandler: _log,

    log: function(message) {
      _log(message, "", "");
    }
  };
})();

// unfortunately, window.onerror is not supported by all browsers...
window.onerror = JsLogger.errorHandler;


