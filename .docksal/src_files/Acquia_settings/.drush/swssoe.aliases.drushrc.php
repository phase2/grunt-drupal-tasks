<?php

// Application 'swssoe', environment 'dev'.
$aliases['dev'] = array (
  'root' => '/var/www/html/swssoe.dev/docroot',
  'ac-site' => 'swssoe',
  'ac-env' => 'dev',
  'ac-realm' => 'prod',
  'uri' => 'swssoedev.prod.acquia-sites.com',
  'path-aliases' => 
  array (
    '%drush-script' => 'drush8',
  ),
  'dev.livedev' => 
  array (
    'parent' => '@swssoe.dev',
    'root' => '/mnt/gfs/swssoe.dev/livedev/docroot',
  ),
  'remote-host' => 'swssoedev.ssh.prod.acquia-sites.com',
  'remote-user' => 'swssoe.dev',
);

// Application 'swssoe', environment 'ode1'.
$aliases['ode1'] = array (
  'root' => '/var/www/html/swssoe.ode1/docroot',
  'ac-site' => 'swssoe',
  'ac-env' => 'ode1',
  'ac-realm' => 'prod',
  'uri' => 'swssoeode1.prod.acquia-sites.com',
  'path-aliases' => 
  array (
    '%drush-script' => 'drush8',
  ),
  'ode1.livedev' => 
  array (
    'parent' => '@swssoe.ode1',
    'root' => '/mnt/gfs/swssoe.ode1/livedev/docroot',
  ),
  'remote-host' => 'swssoeode1.ssh.prod.acquia-sites.com',
  'remote-user' => 'swssoe.ode1',
);

// Application 'swssoe', environment 'ode2'.
$aliases['ode2'] = array (
  'root' => '/var/www/html/swssoe.ode2/docroot',
  'ac-site' => 'swssoe',
  'ac-env' => 'ode2',
  'ac-realm' => 'prod',
  'uri' => 'swssoeode2.prod.acquia-sites.com',
  'path-aliases' => 
  array (
    '%drush-script' => 'drush8',
  ),
  'ode2.livedev' => 
  array (
    'parent' => '@swssoe.ode2',
    'root' => '/mnt/gfs/swssoe.ode2/livedev/docroot',
  ),
  'remote-host' => 'swssoeode2.ssh.prod.acquia-sites.com',
  'remote-user' => 'swssoe.ode2',
);

// Application 'swssoe', environment 'prod'.
$aliases['prod'] = array (
  'root' => '/var/www/html/swssoe.prod/docroot',
  'ac-site' => 'swssoe',
  'ac-env' => 'prod',
  'ac-realm' => 'prod',
  'uri' => 'swssoe.prod.acquia-sites.com',
  'path-aliases' => 
  array (
    '%drush-script' => 'drush8',
  ),
  'prod.livedev' => 
  array (
    'parent' => '@swssoe.prod',
    'root' => '/mnt/gfs/swssoe.prod/livedev/docroot',
  ),
  'remote-host' => 'swssoe.ssh.prod.acquia-sites.com',
  'remote-user' => 'swssoe.prod',
);

// Application 'swssoe', environment 'ra'.
$aliases['ra'] = array (
  'root' => '/var/www/html/swssoe.ra/docroot',
  'ac-site' => 'swssoe',
  'ac-env' => 'ra',
  'ac-realm' => 'prod',
  'uri' => 'swssoera.prod.acquia-sites.com',
  'path-aliases' => 
  array (
    '%drush-script' => 'drush8',
  ),
  'ra.livedev' => 
  array (
    'parent' => '@swssoe.ra',
    'root' => '/mnt/gfs/swssoe.ra/livedev/docroot',
  ),
  'remote-host' => 'swssoera.ssh.prod.acquia-sites.com',
  'remote-user' => 'swssoe.ra',
);

// Application 'swssoe', environment 'test'.
$aliases['test'] = array (
  'root' => '/var/www/html/swssoe.test/docroot',
  'ac-site' => 'swssoe',
  'ac-env' => 'test',
  'ac-realm' => 'prod',
  'uri' => 'swssoestg.prod.acquia-sites.com',
  'path-aliases' => 
  array (
    '%drush-script' => 'drush8',
  ),
  'test.livedev' => 
  array (
    'parent' => '@swssoe.test',
    'root' => '/mnt/gfs/swssoe.test/livedev/docroot',
  ),
  'remote-host' => 'swssoestg.ssh.prod.acquia-sites.com',
  'remote-user' => 'swssoe.test',
);

