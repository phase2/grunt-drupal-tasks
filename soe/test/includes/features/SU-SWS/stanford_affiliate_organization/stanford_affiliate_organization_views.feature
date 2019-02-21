Feature: Stanford Affiliate Organization Views
  In order to ensure that the Affiliates pages are viewable
  As a visitor to the site I want to be able to view pages.

  @safe
  Scenario: Affiliates page is visible and link in the main menu
    When I go to "affiliate-organizations"
    Then I should see "Affiliates" in the "Content Head" region
