Feature: Stanford Date TimePicker
  In order to ensure that the DateTimePicker is available
  As an adminstrator to the site I want to be able to pick time.

  @api @safe
  Scenario: Check to see that the admin page is available
    Given I am logged in as a user with the "administrator" role
    And I am on "admin/config/stanford/datetimepicker"
    Then I should see "Stanford Date Timepicker"
    And I should see "The class used to attach timepickers"
    And I should see "The default date format used by the timepicker"
    And I should see "The default time format used by the timepicker"
    And I should see "The default separator used between date/time. eg: | or -"
    And I should see "Minute interval increment"

  @api @safe
  Scenario: Check to see that the jquery library is installed
    Given I am logged in as a user with the "administrator" role
    And I am on "admin/reports/status"
    Then I should see "jquery-ui-timepicker-addon.js"
    Then I should see "The required jquery-ui-timepicker library is installed"
