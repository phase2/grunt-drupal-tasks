Feature: Stanford Manage Content
  In order to ensure that the Stanford Manage Content displays properly
  As an administrator
  I want to verify the display of content.

  @api @safe
  Scenario: Check to see that manage content view is available
    Given the cache has been cleared
    And I am logged in as a user with the "administrator" role
    And I am on "admin/manage"
    Then I should see the heading "Manage All Content"

  # Can't test location of block since seven module doesn't have correct region.
  @api @safe
  Scenario: Check to see that manage content context
    And I am logged in as a user with the "administrator" role
    And I am on "admin/structure/context"
    Then I should see "manage_content_sub_pages"
    And I should see "manage_content_landing_page"
    And I am on "admin/structure/menu"
    Then I should see "Manage Content by Type"

  @api @safe @javascript
  Scenario: Check context has correct reactions
    Given I am logged in as a user with the "administrator" role
    And I am on "admin/structure/context/list/manage_content_landing_page/edit"
    Then I click on the element with css selector ".context-plugin-block a"
    And I should see "Manage Content by Type"
    Then I am on "admin/structure/context/list/manage_content_sub_pages/edit"
    And I click on the element with css selector ".context-plugin-block a"
    Then I should see "View: Stanford Manage All Content Link"
    And I click on the element with css selector ".context-plugin-path a"
    Then I should see "admin/manage/*"

  @api @dev @destructive @javascript
  Scenario: Check that proper content is deleted
    Given I am logged in as a user with the "administrator" role
    And the "stanford_manage_content" module is enabled
    When I go to "node/add/stanford-page"
    And I enter "Test Page l1ld0pvk 1" for "Title"
    And I press the "Save" button
    Then I should see "Stanford Page Test Page l1ld0pvk 1 has been created"
    When I go to "node/add/stanford-page"
    And I enter "Test Page l1ld0pvk 2" for "Title"
    And I press the "Save" button
    Then I should see "Stanford Page Test Page l1ld0pvk 2 has been created"
    When I go to "node/add/stanford-page"
    And I enter "Test Page l1ld0pvk 3" for "Title"
    And I press the "Save" button
    Then I should see "Stanford Page Test Page l1ld0pvk 3 has been created"
    When I go to "node/add/stanford-page"
    And I enter "Test Page l1ld0pvk 4" for "Title"
    And I press the "Save" button
    Then I should see "Stanford Page Test Page l1ld0pvk 4 has been created"
    When I go to "admin/manage"
    And I enter "Test Page l1ld0pvk" for "Filter by Title"
    And I press the "Apply" button
    Then I should see "Test Page l1ld0pvk 1"
    Then I should see "Test Page l1ld0pvk 2"
    Then I should see "Test Page l1ld0pvk 3"
    Then I should see "Test Page l1ld0pvk 4"
    And I check the box "edit-views-bulk-operations-0"
    And I check the box "edit-views-bulk-operations-2"
    And I check the box "edit-views-bulk-operations-3"
    And I select "Delete item" from "edit-operation"
    And I press the "Execute" button
    Then I should see "You selected the following 3 items"
    And I should see "Test Page l1ld0pvk 4"
    And I should see "Test Page l1ld0pvk 2"
    And I should see "Test Page l1ld0pvk 1"
    When I press the "Confirm" button
    And I wait for the batch job to finish
    Then I should see "Test Page l1ld0pvk 3"
    And I should not see "Test Page l1ld0pvk 1"
    And I should not see "Test Page l1ld0pvk 2"
    And I should not see "Test Page l1ld0pvk 4"
#    Given a "stanford_page" with the title "Stanford Manage Content Test Page 5"
#    When I go to "stanford-manage-content-test-page-5"
#    And I wait 20 seconds
