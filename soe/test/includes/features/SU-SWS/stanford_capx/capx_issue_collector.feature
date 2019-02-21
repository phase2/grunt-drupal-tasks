Feature: Stanford CAPx Issue Collector
  In order to ensure that the capx module is installed and functional
  As an administrative user
  I want to ensure that the Stanford CAP Extensible module is working properly

  @api @dev @safe
  Scenario: Stanford CAP Extensible
    Given the "capx_issue_collector" module is enabled
    Given I am logged in as a user with the "administrator" role
    And I am on "admin/config/capx/settings"
    Then I should see "capx_issue_collector.js"
    # Travis hangs at the end for some unknown reason. The homepage step is silly, but prevents the hang.
    When I am on the homepage

