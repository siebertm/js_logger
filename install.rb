puts <<-EOC
To complete the installation of the JsLogger plugin, you'll need to do the
following steps:

1. cp vendor/plugins/js_logger/db/migrate/* db/migrate/
2. cp vendor/plugins/js_logger/public/javascript/js_logger.js public/javascript
3. include the javascript file in your layout
4. Log! JsLogger.log("message")


Javascript errors are logged automatically

EOC

