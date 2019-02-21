Feature: Stanford Event Series Views
  In order to ensure that the Event series functionality is complete
  As an administrator
  I want to be able to create, edit, delete, and view event series nodes.

  @safe
  Scenario: Event series link in the main menu
    When I go to "events/series"
    Then I should see "Event Series" in the "First sidebar" region
    Then I should see "Event Series" in the "Content Head" region

  @safe
  Scenario: Event series content exists
    When I go to "events/series"
    Then I should see 1 or more ".view-stanford-event-series-list .views-row" elements
