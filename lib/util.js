module.exports = {
  // Dynamically determine the ideal concurrency for parallel operations.
  // Algorithm courtesy of grunt-concurrent.
  concurrency: Math.max((require('os').cpus().length || 1) * 2, 2),
  // Assemble an array of absolute URLs
  expandUrls: function(baseUrl, paths) {
    return paths.map(function(value, index, arr) {
      return baseUrl + value;
    });
  }
};
