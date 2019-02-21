Feature: Stanford FAQ
  In order to ensure that the faq pages are viewable
  As a visitor to the site I want to be able to view pages.

  @api @safe
  Scenario: FAQ view is enabled
    Given I am logged in as a user with the "administrator" role
    And I am on "admin/structure/views"
    Then I should see "Stanford show/hide FAQ hierarchy" in the "Content Body" region
