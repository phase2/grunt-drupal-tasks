Feature: Stanford Person
  In order to ensure that the Stanford Person content type and supporting functionality works.
  As an end user and administrator
  I want to check for the creation and display of people content.

  @api @dev @destructive
  Scenario: Administrator can create a Stanford Person
    Given the cache has been cleared
    And I am logged in as a user with the "administrator" role
    And I am on "node/add/stanford-person"
    When I enter "Leland" for "First name *"
    And I enter "Stanford" for "Last Name *"
    And I enter "Leland Stanford" for "Display Name"
    And I press the "Save" button
    Then I should be on "people/leland-stanford"
    And I should see "Person Leland Stanford has been created"

  @api @safe
  Scenario: Affiliates column on Manage Person
    Given I am logged in as a user with the "administrator" role
    When I go to "admin/manage/people"
    Then I should see 1 or more ".views-field-field-s-person-affiliation" elements

  @deploy
  Scenario: Stanford Person node page
    Given I am on "people/jacob-smith"
    Then I should see "People" in the "First sidebar" region
    Then I should see "Contact" in the "Second sidebar" region
    Then I should see "Office Hours" in the "Second sidebar" region