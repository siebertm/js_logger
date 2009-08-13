module("JsLogger", {
  setup: function() {
    /*
     * mock out new Image() calls
     */
    Image = function() {
      images.push(this);
    }

    images = [];
  },

  teardown: function() {
  }
});


test("calling log should insert a new Image into the document", function() {
  var image_count = images.length;

  JsLogger.log("foo");
  equals(images.length, image_count + 1)
});

test("the images url should be correct", function() {
  JsLogger.log("test message");

  var img = images[0];

  ok(/^\/js\/logger\?message=test%20message/i.test(img.src), "src was " + img.src);
});
