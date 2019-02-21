Feature: Entity API
  Verify entity api functionality

  @safe @api
  Scenario: Entity API
    Given I am logged in as a user with the "administrator" role
    And I am on "/help/entity/README.txt"
    Then I should see the text "This module extends the entity API of Drupal core in order to provide a unified" in the "Content" region
