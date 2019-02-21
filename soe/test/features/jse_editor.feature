@api
Feature: Editor
  In order to ensure that the Jumpstart Engineering administration functions are working properly
  As an Editor
  I want to check for my ability to complete my tasks

  Background:
    Given I am logged in as a user with the "editor" role

  @safe
  Scenario: View the Get Help Page
    And I am on "admin/stanford-jumpstart"
    Then I should see the heading "Jumpstart User Guide"
    And I should see the heading "Drupal resources at Stanford"
    And I should see the heading "Connect with the Drupal Community"
    And I should see the heading "Need assistance with your site?"
    And I should see the link "Request Assistance" in the "Content Body" region

  @safe
  Scenario: View the Ready to Launch page
    And I am on "admin/stanford-jumpstart/launch-checklist"
    Then I should see the heading "Content Cleanup"
    And I should see the heading "Blocks"
    And I should see the heading "Images"
    And I should see the heading "Links"
    And I should see the heading "URL Redirects"
    And I should see the heading "Vanity URL"
    And I should see the heading "Approval"
    And I should see the heading "Are you ready to launch your site?"
    And I should see the link "Request Site Launch" in the "Content Body" region

  @javascript @dev @destructive
  Scenario: Edit Social Media Links
    And I wait for the Site Actions drop down to appear
    And I click "Edit Social Media Links" in the "Admin Shortcuts" region
    Then I should see "Edit stanford_social_media_connect: Jumpstart Footer Social Media Connect Block" in the "Branding" region
    When I press the "Save" button
    Then I should see "has been updated." in the "Console" region

  @safe
  Scenario: Create Stanford event
    Given I am on "node/add/stanford-event"
    Then I should see "Create Stanford Event" in the "Branding" region

  @safe
  Scenario: Site editor is denied access to add an Event series node
    When I go to "node/add/stanford-event-series"
    Then I should see "Access denied"

#  @javascript @safe
#  Scenario: Site editor can clear caches
#    And I wait for the Site Actions drop down to appear
#    And I click "Clear Site Cache" in the "Admin Shortcuts" region
#    Then I should see "Site Cache Cleared" in the "Console" region

  @safe
  Scenario: Event series link in the site actions menu
    When I go to "node/add/stanford-event-series"
    Then I should see "Access denied"
