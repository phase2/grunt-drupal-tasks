#Site Setup

##Steps to setup

1. Clone repo -- will default SOE-develop-mc branch.
2. Checkout new branch, e.g., `git checkout -b SOE-jiraticket-shortdescription`
3. Edit the following files, which are located ./docksal
    1. Add branch name to line six in Gruntfile.js.
    2. Edit soe.aliases.drushrc.php, making sure the slugs path to build/html is correct.
    3. Optional: edit settings.local.php, updating the `base_url` var. Note that the `base_url` is set based on the directory name of this repository, e.g., `grunt-drupal-tasks.docksal`.
4. If you use a key other than `id_rsa` to connect to Acquia, run `fin ssh-key add <keyname>` (e.g., `fin ssh-key add id_rsa_acquia_4096`)
5. Run `fin init`

##Links
https://github.com/SU-SOE/grunt-drupal-tasks/blob/SOE-develop-mc/docs/soe_build_notes.md
https://stackoverflow.com/questions/47008159/how-to-downgrade-node-version
https://www.npmjs.com/package/n
https://phase2.github.io/grunt-drupal-tasks/10_BUILD/
https://www.drupal.org/node/1401522