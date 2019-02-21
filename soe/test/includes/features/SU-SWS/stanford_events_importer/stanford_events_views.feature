Feature: Stanford Events Views
  In order to verify that Stanford events views functionality
  As an end user
  I want to check for the existence of events content

  @api @safe
  Scenario: See upcoming events content
    Given the cache has been cleared
    And I am on "events/upcoming-events"
    Then I should see a ".event-title" element
    And I should see a ".event-date-long" element

  @safe
  Scenario: See past events - check for pager
    Given I am on "events/past-events"
    Then I should see 5 or fewer ".event-title" elements
