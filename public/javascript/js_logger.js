jQuery(document).ready(function() {
  JsLogger = function() {
    var loggerUrl = "/js/logger";

    /**
     * logs a message to the server
     */
    var _log = function(message, url, line) {
      var parameters = "?message=" + escape(message) +
                       "&url=" + escape(url) +
                       "&line=" + escape(line) +
                       "&parent_url=" + escape(document.location.href) +
                       "&user_agent=" + escape(navigator.userAgent);

      /** Send error to server */
      new Image().src = loggerUrl + parameters;
      return true;
    };


    return {
      errorHandler: _log,

      log: function(message) {
        _log(message, "", "");
      }
    };
  }();

  // unfortunately, window.onerror is not supported by all browsers...
  window.onerror = JsLogger.errorHandler;
});


