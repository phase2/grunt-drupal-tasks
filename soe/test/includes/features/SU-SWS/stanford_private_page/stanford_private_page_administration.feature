Feature: Stanford Private Page Administration
  In order to verify the Stanford Private Page manage content pages functioning
  As an administrator
  I want to verify functionality

  @safe @api @deploy
  Scenario: Verify manage Private Page exists
    Given I am logged in as a user with the "administrator" role
    When I go to "admin/manage/private-page"
    Then I should see 1 or more ".view-stanford-private-page-manage" elements
