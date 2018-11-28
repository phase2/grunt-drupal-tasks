core = 7.x
api = 2

; Patches
; ------------------------------------------------------------------------------

; https://www.drupal.org/project/drupal/issues/1349080#comment-10953027 | node_access filters out accessible nodes when node is left joined
projects[drupal][patch][] = "https://www.drupal.org/files/issues/node_access_for_left_joins_d7.1349080-332.patch"

; https://www.drupal.org/node/1904174 | Context pulling out css injector files when aggregation enabled
projects[context][patch][] = "https://www.drupal.org/files/issues/context_css_injector_1.diff"

; https://www.drupal.org/node/2471911 Form validation fails with "the directory is not writable" when public file system is remote
projects[css_injector][patch][] = "https://www.drupal.org/files/issues/css_injector-remove_drupal_realpath-2471911-2.patch"

; https://www.drupal.org/node/2160385 - PHP notices after clicking "Edit rule"
projects[css_injector][patch][] = "https://www.drupal.org/files/issues/css_injector-bad_crid_protection-2160385-10.patch"

; https://www.drupal.org/node/2375235 Calendar block Next/Prev navigation broken
projects[date][patch][] = "https://www.drupal.org/files/issues/calendar_pager_broken-2375235-35.patch"

; https://www.drupal.org/node/2221307 | Patch allows for field groups to be rendered in ds custom block regions
projects[ds][patch][] = "https://www.drupal.org/files/issues/ds_extras_field_group_not_rendered-2221307-18.patch"

; https://drupal.org/node/927566 & https://drupal.org/node/860974 | Menu Links will not import/revert
projects[features][patch][] = "https://drupal.org/files/issues/features-parent_identifier-927566-79.patch"

; https://www.drupal.org/node/2567431 | PHP 7 critical error fix
projects[feeds_tamper][patch][] = "https://www.drupal.org/files/issues/feeds_tamper-fix-params-default-value-callback-2567431-2-7.x.patch"

; https://www.drupal.org/node/2713921 | Cannot install on mysql 5.7+
projects[jw_player][patch][] = "https://www.drupal.org/files/issues/jw-player-mysql57-2713921-8.patch"

; https://drupal.org/node/1267966 - entity tokens bugs
projects[pathauto][patch][] = "https://drupal.org/files/pathauto_admin.patch"

; https://www.drupal.org/node/2811063 | Fatal error: Cannot use lexical variable $value as a parameter name in components/select.inc on line 765
projects[webform][patch][] = "https://www.drupal.org/files/issues/webform-2811063-47.patch"

; https://www.drupal.org/project/custom_meta/issues/2909861 | php 7.1 compatability
projects[custom_meta][patch][] = "https://www.drupal.org/files/issues/2018-04-30/2909861-5.patch"

; https://www.drupal.org/project/views_ajax_history/issues/2942777 | Exposed filters: url doesnt change if select filter has no selected values
projects[views_ajax_history][patch][] = "https://www.drupal.org/files/issues/2018-05-18/views_ajax_history.remove-existing-parameters.patch"

; https://www.drupal.org/project/views_load_more/issues/1690692 | Bug with exposed filters
projects[views_load_more][patch][] = "https://www.drupal.org/files/issues/views-load-more-exposed-filters-1690692-7.patch"

; https://www.drupal.org/project/xmlsitemap/issues/2986847 | PHP fatal error when a node is deleted while the node ID is still in the queue
projects[xmlsitemap][patch][] = "https://www.drupal.org/files/issues/2018-07-19/xmlsitemap-2986847-2.patch"

; custom patch for letsencrypt_challenge to work with acme.sh script on ACE env's
projects[letsencrypt_challenge][patch][] = "https://gist.githubusercontent.com/boznik/e47f023e330345519598813f13fe2d40/raw/9a995c9254174fb5997147176d05af33403ab6dc/d7-acme-sh-letsencrypt_challenge.patch"

: https://www.drupal.org/project/video_embed_field/issues/2580459 | Not all video style options are being applied
projects[video_embed][patch][] = "https://www.drupal.org/files/issues/youtube_autoplay-2580459-25.patch"
