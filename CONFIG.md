
# Configuration Options for Drupal Grunt Build and Testing Tasks

This documents all configuration options for Drupal Grunt Build and Testing
Tasks. These options are defined in the Gruntconfig.json file.

For an example of many options, see Gruntconfig.json in the example directory.

## Core

### config.srcPaths.drupal

Specifies the directory that contains all project-specific Drupal code and configuration.

Grunt Drupal Tasks assumes this directory has the following structure:

```
source/
  modules/
  profiles/
  sites/
  static/
  themes/
```

### config.srcPaths.make

Specifies the Drush make file used to build the Drupal project.

### config.buildPaths.build

Specifies the directory that should be used for miscellaneous build artifacts. This can be the parent directory of config.buildPaths.html and config.buildPaths.reports.

### config.buildPaths.html

Specifies the directory that should be used for the Drupal docroot build destination.

### config.buildPaths.reports

Specifies the directory that should be used for output from the analysis and validation tools.

## Analyze

### config.phpmd.configPath

### config.phpmd.path

## Behat

### config.siteUrls

## Drush

### config.drush.make.args

## Package

### config.packages.srcFiles

### config.packages.projFiles

## Theme

### config.themes

## Validate

### config.phpcs.path

### config.phpcs.standard
