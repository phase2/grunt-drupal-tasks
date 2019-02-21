Feature: module
  In order to ensure the site is functioning as expected
  As anonymous user
  I want to verify permissions and access

  @safe @javascript
  Scenario: User login
    Given I am on "/user"
    When I click "Local User Login"
    And I fill in "Local Drupal Username" with "foo"
    And I fill in "Local Drupal Password" with "bar"
    And I press "Log in"
    Then I should see "Sorry, unrecognized username or password"
