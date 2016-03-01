var spawn = require("child_process").spawn;

module.exports = {
  // Dynamically determine the ideal concurrency for parallel operations.
  // Algorithm courtesy of grunt-concurrent.
  concurrency: Math.max((require('os').cpus().length || 1) * 2, 2),
  // Assemble an array of absolute URLs
  expandUrls: function(baseUrl, paths) {
    return paths.map(function(value, index, arr) {
      return baseUrl + value;
    });
  },
  canRsync: function() {
    var platform = options.platform || process.platform; // Enable process.platform to be mocked in options for testing
    return platform === "win32";
  }
};
