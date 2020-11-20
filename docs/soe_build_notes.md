# SOE Build Documentation

> Get Node (-v 10.x), Grunt, & Composer on you machine.

> Initial Setup

* clone repo will default SOE-develop-mc branch.
* `git checkout -b SOE-jiraticket-shortdescription`
* npm install
* move into soe dir
* npm install
* composer install
* create drush alias file for your local env
* modify Gruntconfig.json  for domain, alias and local path to drush
* modify Gruntfile.js. Set `deploy_site.development.options.branch` to your new `SOE-jiraticket-shortdescription`
* touch src/engineering.make as this tells grunt that a change has been made to the build
* run: `grunt`
* run: `grunt settings`
* copy default.settings.local.php to settings.local.php and put info in there
* if not running https comment out line 8-13 in settings.php but undo before packaging.


> Here are the commands defined inside the `scripts` configuration.

* `grunt settings` adds required settings files. Alter settings.local.php for your local environment
* `grunt syncfiles` syncs local files dir with ACE test environment
*  `grunt syncdb` syncs local database with ACE test environment and disables stanford_ssp acquia_connector acquia_purge expire
*  `grunt update` runs drush updb on local
*  `grunt reset` runs drush rr and drush cc all on local
*  `grunt reset` runs drush rr and drush cc all on local
*  `grunt localadmin` sets local admin login to admin/admin

> More grunt commands

* `grunt behat` runs behat tests located in soe/test/features directory
* `grunt package` packages the build/html directory to the build/packages/package dir for proper ACE formatting
* `grunt git_deploy` adds acquia dependencies, the simplesaml symlink and deploys the build/packages/package dir to the [Artifact Repo](https://github.com/SU-SWS/sws_soe_ace)

> Deployment 

* be sure forcing https is uncommented in settings.php
* run: `grunt package`
* check to make sure build/packages/package has correct code
* run: `grunt git_deploy` this will send the branch you set in Gruntfile.js setting `deploy_site.development.options.branch` to the [Artifact Repo](https://github.com/SU-SWS/sws_soe_ace)
* check artifact repo for structure and code integrity
* pull branch from artifact repo to local and push to ACE remote
* test branch on [dev](https://eng-dev.stanford.edu)

> Solr Configuration

1. Login credentials can be found at: https://asconfluence.stanford.edu/confluence/display/SWS/External+Account+Credentials#space-menu-link-content

Look for: https://hostedapachesolr.com

hostedapachesolr login page is at: https://hostedapachesolr.com/user/login

2. SOE configuration

- SOE setup information is located at: https://hostedapachesolr.com/support/setup/896

- SOE uses Basic Auth to connect with the Solr server

- SOE configuration files must be sent to the support team of the service for implementation as there is no self service admin section.

3. Settings in Dev and Test environments

- If you navigate to:

admin/config/search/search_api/index/solr_nodes_now/edit

Read only should be checked in both dev and test environments.

- There is code for this setting as well at: https://github.com/SU-SOE/grunt-drupal-tasks/blob/SOE-develop-mc/soe/build_settings/acquia.settings.php#L26

4. Magazine only search code is located at: https://github.com/SU-SOE/stanford_soe_helper/tree/7.x-2.x/modules/stanford_soe_helper_search

The magazine only search uses the same index as the whole site search. The magazine only search returns results via the view named: DM Search SOLR Nodes. This view filters results so that only magazine issues and articles are returned.

5. Backup of current schema.xml is stored in soe/docs directory.
