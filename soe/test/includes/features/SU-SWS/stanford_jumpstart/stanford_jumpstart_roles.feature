Feature: Stanford Sites Jumpstart Roles
  In order to ensure that functionality of the module
  I want to ensure the roles exist.

  @api @safe
  Scenario: Validate roles exist
    Given I run drush "rls"
    Then drush output should contain "site owner"
    And drush output should contain "editor"
    And drush output should contain "site member"

