Feature: Stanford Jumpstart Academic
  In order to ensure that the module functions
  As an end user
  I want to check for the css.

  @api @safe
  Scenario: Check the module is enabled
    # Nothing elese in the module to check for.
    Given I am logged in as a user with the "administrator" role
    And I am on "admin/modules"
    Then the "modules[Other][stanford_jumpstart_academic][enable]" checkbox should be checked
