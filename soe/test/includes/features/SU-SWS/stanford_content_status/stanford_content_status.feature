Feature: Stanford Content Status
  In order to track content status during site development
  As a content creator
  I need to be able to know which content has a given status

@api @safe
Scenario: See Content Status and Notes in the node edit form
  Given I am logged in as a user with the "site owner" role
  And I am on "node/add/stanford-page"
  Then I should see "Content Status"
  And I should see "Content Notes"

@api @safe
Scenario: See the Manager Dashbaord
  Given I am logged in as a user with the "site owner" role
  And I am on "admin/stanford/jumpstart/manager-dashboard"
  Then I should see "Content Status Count"
  And I should see 1 or more "table" elements
