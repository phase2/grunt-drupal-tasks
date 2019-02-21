Feature: Help Content Type
  In order to be able to create help content within the site
  As a site admin
  I want to have a Help content type and menu structure behind webauth

@api @safe
Scenario: Create Help Content type and Menu item
 Given I am logged in as a user with the "administrator" role
 And I am on "/node/add/stanford-help-page"
 Then I should see the heading "Create Help Page"

# @api @safe @live @site
# Scenario: See existing Help content
#  Given I am logged in as a user with the "administrator" role
#  And I am on "/node/157"
#  Then I should see "Overview" in the "Second sidebar" region
