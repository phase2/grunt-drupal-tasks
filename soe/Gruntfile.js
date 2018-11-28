module.exports = function(grunt) {
  // Load all plugins and tasks defined by the grunt-drupal-tasks package.
  require('grunt-drupal-tasks')(grunt);
  grunt.loadNpmTasks('grunt-deploy-site');
  grunt.loadNpmTasks('grunt-symlink');
  grunt.config.set('deploy_site.development.options.branch', 'SOE-develop-mc');
  grunt.config.set('deploy_site.development.options.commit_msg', 'deployment');
  grunt.config.set('deploy_site.development.base_path', 'build/packages/package');
  grunt.config.set('deploy_site.development.remote_url', 'git@github.com:SU-SWS/sws_soe_ace.git');
  grunt.config.set('copy.acquia_dependencies.expand', true);
  grunt.config.set('copy.acquia_dependencies.cwd', 'acquia_dependencies/');
  grunt.config.set('copy.acquia_dependencies.src', '*/**');
  grunt.config.set('copy.acquia_dependencies.dest', 'build/packages/package/');
  grunt.config.set('symlink.simplesaml_symlink.dest', 'build/packages/package/docroot/simplesaml');
  grunt.config.set('symlink.simplesaml_symlink.relativeSrc', '../simplesamlphp/www');
  grunt.config.set('symlink.simplesaml_symlink.options', {type: 'dir'});
  grunt.registerTask('git_deploy', ['copy:acquia_dependencies', 'symlink:simplesaml_symlink', 'deploy_site']);
};
