module.exports = function(grunt) {
  /*
  *   Define parallel tasks
  *
  *   Dynamically adds parallel tasks based on configuration file
  *
  *   Example:
  *
  *   "parallel": {
  *     "all": {
  *       "options": {
  *         "stream": true
  *        },
  *        "tasks": [{
  *          "grunt": true,
  *            "args": ["watch:compass"]
  *           }, {
  *          "grunt": true,
  *            "args": ["watch:css"]
  *           }, {
  *          "grunt": true,
  *            "args": ["watch:validate"]
  *           }, {
  *          "grunt": true,
  *            "args": ["watch:behat"]
  *          }]
  *       }
  *     }
  *   }
  */

  grunt.loadNpmTasks('grunt-parallel');

  var config = grunt.config.get('config');

  // Allow users to specify unique targets combining numerous tasks into distinct parallel target
  if (config.parallel) {
    for (var key in config.parallel) {
      if (config.parallel.hasOwnProperty(key) && config.parallel[key]) {
        var options = (config.parallel[key] && typeof config.parallel[key] === 'object') ? config.parallel[key] : {};

        grunt.config(['parallel', key], options);
      }
    }
  }
};