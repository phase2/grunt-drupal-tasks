Feature: Stanford Events Export
  In order to ensure
  As an administrative user
  I want to ensure that

  @api @dev
  Scenario: Test the events export pages.
    Given the "stanford_events_export" module is enabled
    And I am logged in as a user with the "administrator" role
    And I am on "admin/structure/views/view/stanford_events_export/edit"
    Then I should see the heading "Stanford Events Export (Content)"
    And I am on "stanford-events/xml"
    Then the response header "Content-Type" should contain "text/xml; charset=utf-8"
    Then I am on "stanford-events/json"
    Then I should get a "200" HTTP response
    And I should not see the heading "Page not found"
