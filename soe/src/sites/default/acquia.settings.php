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
      $conf['acquia_purge_domains'] = array('eng-dev.stanford.edu');
      break;
    case 'test':
      $conf['stanford_simplesamlphp_auth_installdir'] = '/var/www/html/swssoe.test/simplesamlphp';
      $conf['acquia_purge_domains'] = array('eng-stage.stanford.edu');
      break;
    case 'prod':
      $conf['stanford_simplesamlphp_auth_installdir'] = '/var/www/html/swssoe.prod/simplesamlphp';
      $conf['acquia_purge_domains'] = array('engineering-legacy.stanford.edu');
      break;
  }
}

// Disabling solr for indexing except on prod
if (!isset($_ENV['AH_SITE_ENVIRONMENT'])  || 'prod' != $_ENV['AH_SITE_ENVIRONMENT']) {
  $conf['apachesolr_read_only'] = "1";
}

$conf['acquia_purge_http'] = FALSE;

$conf['acquia_purge_https'] = TRUE;

// Set the Strict Transport Security header.
// See https://support.acquia.com/hc/en-us/articles/360004119254-How-To-enable-HSTS-for-your-Drupal-site.
header('Strict-Transport-Security: max-age=31536000');

