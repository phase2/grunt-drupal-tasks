Feature: Stanford Manage Content
  In order to ensure that the Stanford Manage Content displays properly
  As an administrator
  I want to verify the display of content.

  Background:
    Given I am logged in as a user with the "administrator" role

  @api @safe
  Scenario: Check to see that manage content view is available
    Given the cache has been cleared
    And I am on "admin/manage"
    Then I should see the heading "Manage All Content"

  # Can't test location of block since seven module doesn't have correct region.
  @api @safe
  Scenario: Check to see that manage content context
    And I am on "admin/structure/context"
    Then I should see "manage_content_sub_pages"
    And I should see "manage_content_landing_page"
    And I am on "admin/structure/menu"
    Then I should see "Manage Content by Type"

  @api @safe
  Scenario: Check context has correct reactions
    And I am on "admin/structure/context/list/manage_content_landing_page/edit"
    Then I click on the element with css selector ".context-plugin-block a"
    And I should see "Manage Content by Type"
    Then I am on "admin/structure/context/list/manage_content_sub_pages/edit"
    And I click on the element with css selector ".context-plugin-block a"
    Then I should see "View: Stanford Manage All Content Link"
    And I click on the element with css selector ".context-plugin-path a"
    Then I should see "admin/manage/*"


