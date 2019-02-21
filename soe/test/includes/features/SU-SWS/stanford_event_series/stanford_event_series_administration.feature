Feature: Stanford Event Series Administration
  In order to ensure that the Event series functionality is complete
  As an administrator I want to verify the manage content page exists

  @api @safe
  Scenario: Event series column on manage events page
    Given I am logged in as a user with the "administrator" role
    When I go to "admin/manage/events"
    Then I should see 1 or more ".views-field-field-s-event-series" elements


