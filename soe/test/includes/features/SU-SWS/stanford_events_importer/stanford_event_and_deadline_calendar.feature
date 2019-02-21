Feature: Stanford Events and Deadlines Calendar
  In order to ensure that the module functions correctly
  As an administrative user
  I want to ensure that the views exist and content is diaplyed

  @api @dev
  Scenario: Test the Events content type fields
    Given the "stanford_events_and_deadlines_calendar" module is enabled
    And I am logged in as a user with the "administrator" role
    And I am on "admin/structure/types/manage/stanford-event/fields"
    Then I should see the heading "Stanford Event"
    And I should see "field_stanford_event_deadline"

  @api @dev
  Scenario: Test for valid views & displays
    Given I am logged in as a user with the "administrator" role
    And I am on "admin/structure/views/view/stanford_create_new_event_link/edit"
    Then I should see the heading "Create new event link (Content)"
    Then I am on "admin/structure/views/view/stanford_undergrad_calendar/edit"
    And I should see the heading "Stanford Undergrad Calendar (Content)"

  @api @dev
  Scenario: Create Stanford Event Content With a deadline
    Given I am logged in as a user with the "administrator" role
    And I am on "node/add/stanford-event"
    Then I enter "Test Event" for "title"
    And I select the "Yes" radio button
    And I enter "Test Location" for "Location"
    And I enter "Test Admission" for "Admission"
    And I enter "Test Body" for "Body"
    And I enter "google.com" for "edit-field-s-event-map-link-und-0-url"
    And I enter "Test Sponsor" for "Event Sponsor"
    And I enter "Test@email.com" for "Contact Email"
    And I enter "111-111-1111" for "Contact Phone"
    And I enter "More Label" for "Title"
    And I enter "google.com" for "field_stanford_event_url[und][0][url]"
    And I press the "Save" button
    Then I am on "calendar/month"
    And I should see "Test Event"
