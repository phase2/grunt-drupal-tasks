Feature: Stanford Site Actions
  In order to ensure that functionality of the module
  As an administrative user
  I want to ensure the links exist.

  @api @safe
  Scenario: Check if menu Links exist
    Given I am logged in as a user with the "administrator" role
    And I am on the homepage
    Then I should see the link "Edit Contact Information" in the "Admin Shortcuts" region
    And I should see the link "Edit Social Media Links" in the "Admin Shortcuts" region