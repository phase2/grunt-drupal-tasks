Feature: Stanford Sites Jumpstart Layouts
  In order to ensure that functionality of the module
  As an administrative user
  I want to ensure that the context rules exist.

  @api @safe @javascript
  Scenario: Validate contexts exist and the blocks reations are accurate.
    Given the "stanford_jumpstart_layouts" module is enabled
    And I am logged in as a user with the "administrator" role
    Then I am on "admin/structure/block"
    And I should see "Main Menu - Primary - 1 Depth"
    And I should see "Main Menu - Secondary - 2 Depths"
    Then I am on "admin/structure/context"
    And I should see the heading "Context"
    And I should see "12-col-banner-nsb-homepage"
    And I should see "9-col-banner-fsb-homepage"
    And I should see "all_pages_but_homepage"
    And I should see "Sitewide - All pages"
    Then I am on "admin/structure/context/list/sitewide/edit"
    And I click on the element with css selector ".context-plugin-block a"
    And I should see "Main Menu - Primary - 1 Depth"
    And I should see "Search Form"
