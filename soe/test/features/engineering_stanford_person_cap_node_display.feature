Feature: Stanford CAP Person Node Display
  In order to ensure that the Stanford Person CAP Profile displays properly
  As an end user
  I want to verify the CAP display of people content.

  @api @dev @destructive
  Scenario: Administrator can create a Stanford Person
    And the cache has been cleared
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



