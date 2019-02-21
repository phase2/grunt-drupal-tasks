Feature: Related Content
  In order to ensure related content field
  As an authenticated user
  I want to check that I can see Related Content field

  @api @safe
  Scenario: Select related content
    Given I am logged in as a user with the "site owner" role
    And I am on "node/add/stanford-page"
    Then I should see "Related Content" in the "Content Body" region
