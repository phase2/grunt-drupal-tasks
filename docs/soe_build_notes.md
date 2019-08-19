# SOE Build Documentation

> Get Node, Grunt, & Composer on you machine.

> Initial Setup

* clone repo will default SOE-develop-mc branch.
* `git co -b SOE-jiraticket-shortdescription`
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