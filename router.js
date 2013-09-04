// Generated by CoffeeScript 1.6.3
(function() {
  var route;

  route = function(handle, pathName) {
    console.log("About to route a request for " + pathName);
    if (typeof handle[pathName] === 'function') {
      return handle[pathName]();
    } else {
      return console.log("No request handler found for " + pathName);
    }
  };

  exports.route = route;

}).call(this);