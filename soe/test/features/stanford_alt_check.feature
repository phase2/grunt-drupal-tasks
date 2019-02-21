Feature: Stanford Alt Check
  Verify stanford alt check

  @safe @api
  Scenario: Stanford Alt Check
    Given I am logged in as a user with the "administrator" role
    And I am on "/admin/content/images"
    Then I should see the text "Filter" in the "Content" region