// Generated by CoffeeScript 1.6.3
(function() {
  var start, upload;

  start = function() {
    var sleep;
    console.log("start wos called");
    sleep = function(milliSeconds) {
      var i, startTime, _results;
      startTime = new Date().getTime();
      i = 0;
      _results = [];
      while (new Date().getTime() < startTime + milliSeconds) {
        _results.push(i++);
      }
      return _results;
    };
    sleep(10000);
    return 'hello start';
  };

  upload = function() {
    console.log("upload wos called");
    return 'hello upload';
  };

  exports.start = start;

  exports.upload = upload;

}).call(this);