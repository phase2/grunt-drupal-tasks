Feature: Stanford Date Formats
  In order to ensure that upgrades do not break existing functionality
  As an administrative user
  I want to ensure that the Stanford Date Formats module is working properly

  @api @safe
  Scenario: Stanford Date Formats
    Given the cache has been cleared
    And I am logged in as a user with the "administrator" role
    And I am on "admin/config/regional/date-time"
    Then I should see "Date Type"
    And I should see "Time"
    And I should see "Month Date, Year"
    And I should see "Date, Year - Time"
    And I should see "Date, Year - Time with space"
    And I should see "Two Digit Day"
    And I should see "Short Month"
    And I should see "Short Month Day"
    And I should see "Short Month Day | Time"
    And I should see "Short Month Day | Time with space"
    And I should see "Month Two-Digit Day, Year"
    And I should see "Long Day of Week, Date, Year"
    And I should see "Long Day of Week, Date, Year - Time"
    And I should see "Long Day of Week, Date, Year - Time with space"
    And I should see "Long"
    And I should see "Medium"
    And I should see "Short"
