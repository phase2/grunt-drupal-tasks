# CHANGELOG

## v0.5.0

- Moving main Grunt Drupal Tasks library code from Gruntfile.js to bootstrap.js
- Adding integration with OS notification features with grunt-notify
- Adding documentation for use with a continuous integration system
- Many dependency updates
- Other minor improvements

### Upgrade Notes

- Change your project's Gruntfile.js to include grunt-drupal-tasks using
`require('grunt-drupal-tasks')(grunt);` instead of 
`require('grunt-drupal-tasks/Gruntfile')(grunt);`
