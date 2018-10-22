<?php
/**
 * @file
 * This file configures the path to simplesamlphp on a per-environment basis.
 */

if (isset($_ENV['AH_SITE_ENVIRONMENT'])) {
  // simplesamlphp lives in a different directory on different environments
  switch ($_ENV['AH_SITE_ENVIRONMENT'])
  {
    case 'dev':
      $conf['stanford_simplesamlphp_auth_installdir'] = '/var/www/html/swssoe.dev/simplesamlphp';
      break;
    case 'test':
      $conf['stanford_simplesamlphp_auth_installdir'] = '/var/www/html/swssoe.test/simplesamlphp';
      break;
    case 'prod':
      $conf['stanford_simplesamlphp_auth_installdir'] = '/var/www/html/swssoe.prod/simplesamlphp';
      break;
  }
}