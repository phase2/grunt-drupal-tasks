Feature: Stanford BEAN Types
  In order to ensure that upgrades do not break existing functionality
  As an end user
  I want to check that the Stanford BEAN Types module is working correctly

  @api @safe
  Scenario: Stanford BEAN Types
    Given I am logged in as a user with the "administrator" role
    And I am on "block/add"
    Then I should see "Add Block"
