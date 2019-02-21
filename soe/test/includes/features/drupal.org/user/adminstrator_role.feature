Feature: module
  In order to ensure the site is functioning as expected
  As administrator
  I want to verify permissions and access

  @safe @api
  Scenario: User is logged in
    Given I am logged in as a user with the "administrator" role
    And I am on "/user"
    Then I should see "History"
