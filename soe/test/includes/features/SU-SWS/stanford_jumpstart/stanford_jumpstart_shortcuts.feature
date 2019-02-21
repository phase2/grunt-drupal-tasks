Feature: Stanford Sites Jumpstart Shortcuts
  In order to ensure that functionality of the module
  As an administrative user
  I want to ensure the context, block and links exist.

  @api @safe @javascript
  Scenario: Check if menu and context exist.
    Given I am logged in as a user with the "administrator" role
    And I am on "admin/structure/menu"
    Then I should see "Admin Shortcuts"
    Then I am on "admin/structure/context"
    And I should see "stanford_jumpstart_admin_shortcuts"
    Then I am on "admin/structure/context/list/stanford_jumpstart_admin_shortcuts/edit"
    And I click on the element with css selector ".context-plugin-block a"
    And I should see "Admin Shortcuts"
    And I should see "Jumpstart Hello \"User\" Block"

  @api @safe
  Scenario: Check if menu Links exist
    Given I am logged in as a user with the "administrator" role
    And I am on the homepage
    Then I should see the link "Site Actions" in the "Admin Shortcuts" region
    And I should see the link "Customize Design" in the "Admin Shortcuts" region
    And I should see the link "Add Features" in the "Admin Shortcuts" region
    And I should see the link "Log out" in the "Admin Shortcuts" region
    And I should see the link "Manage Users" in the "Admin Shortcuts" region
    And I should see the link "Manage Taxonomies" in the "Admin Shortcuts" region
    And I should see the link "Edit Main Menu" in the "Admin Shortcuts" region
    And I should see the link "Edit Site Name" in the "Admin Shortcuts" region
    And I should see the link "Clear Site Cache" in the "Admin Shortcuts" region