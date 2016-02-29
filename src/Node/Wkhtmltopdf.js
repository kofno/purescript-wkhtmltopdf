"use strict";

// module Node.Wkhtmltopdf


var wkhtmltopdf = require('wkhtmltopdf');

exports.toPDFImpl = function(options) {
  return function(content) {
    return function() {
      return wkhtmltopdf(content, options);
    };
  };
};


exports.toOptionsImpl = function(options) {

  var converted = {};

  for (var key in options) {

    var value = options[key];

    var unwrapped;

    if (typeof value === "string") {
      unwrapped = value;
    }

    else if (typeof value === "number"){
      unwrapped = value
    }

    else {
      unwrapped = value.value0;
    }

    if (typeof unwrapped !== "undefined") {
      converted[key] = unwrapped;
    }

  };

  return converted;
};
