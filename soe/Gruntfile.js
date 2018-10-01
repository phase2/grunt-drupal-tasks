module.exports = function(grunt) {
  // Load all plugins and tasks defined by the grunt-drupal-tasks package.
  require('grunt-drupal-tasks')(grunt);
  grunt.loadNpmTasks('grunt-deploy-site');
  grunt.initConfig({
    deploy_site: {
      development: {
        options: {
          branch: "SOE-3551-tool-tasks",
          commit_msg: "deployment",
        },
        base_path: "build/packages/package",
        remote_url: "git@github.com:boznik/destination_test.git",
      },
    },
    copy: {
      acquia_dependencies: {
        expand: true,
        cwd: 'acquia_dependencies/',
        src: '*/*',
        dest: 'build/packages/package/',
      },
    },
  });
  grunt.registerTask('git_deploy', ['copy:acquia_dependencies', 'deploy_site']);
};
