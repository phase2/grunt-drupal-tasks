module.exports = function(grunt) {
  grunt.initConfig({
    config: {
      "srcPaths": {
        "make": "src/project.make",
        "drupal": "src"
      },
      "siteUrls": {
        "default": "http://project.local"
      },
      "packages": {
        "srcFiles": ["!sites/*/files/**", "!xmlrpc.php", "!modules/php/*"],
        "projFiles": ["README*", "bin/**"]
      },
      "phpcs": {
        "path": "vendor/bin/phpcs"
      },
      "phpmd": {
        "path": "vendor/bin/phpmd"
      },
      "drush": {
        "cmd": "vendor/bin/drush"
      },
      "behat": {
        "flags": "--tags ~@wip"
      },
      "validate": {
        "ignoreError": true
      },
      "eslint": true,
      "scripts": {
        "pre-echo": "echo 'pre-op script'",
        "echo": "echo 'operational scripts run'",
        "post-echo": "echo 'post-op script'"
      },
      "themes": {
        "example_theme": {
          "path": "<%= config.srcPaths.drupal %>/themes/example_theme",
          "scripts": {
            "echo": "echo 'theme scripts run in '$(basename $(pwd))"
          }
        }
      }
    }
  });

  // Load all plugins and tasks defined by the grunt-drupal-tasks package.
  require('grunt-drupal-tasks')(grunt);
};
