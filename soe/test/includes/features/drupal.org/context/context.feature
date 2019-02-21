Feature: module
  In order to ensure the site is functioning as expected
  As administrator
  I want to verify functionality of the context module

  @safe @api
  Scenario: Verify Context is enabled
    Given I am logged in as a user with the "administrator" role
    And I am on "admin/modules"
    Then I should see 1 "#edit-modules-context-context-enable" element
    And the "modules[Context][context][enable]" checkbox should be checked
