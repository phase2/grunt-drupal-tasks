## This feature checks for the content that is deployed on a bunch of our
## products. This content is not bundled in the module and should be kept in its
## own test because of that.

Feature: Stanford Private Page Content
  In order to ensure that the Stanford Private Page Content was successfully deployed
  As all types of users
  I want to check for that the pages exist

  @api @deploy
  Scenario: On deploy, check that the administrator can view all private pages
    Given I am logged in as a user with the "administrator" role
    Given I am on "private"

    Then I should see "Private Pages" in the "First sidebar" region
    And I should see a ".block-menu" element
    And I should see "Private Pages" in the "Content Head" region

    And I click "For Faculty" in the "First sidebar" region
    And I should see "Private Pages" in the "First sidebar" region
    And I should see a ".block-menu" element
    And I should see "For Faculty" in the "Content Head" region

    And I click "Faculty Sub-Page" in the "First sidebar" region
    And I should see "Private Pages" in the "First sidebar" region
    And I should see a ".block-menu" element
    And I should see "Faculty Sub-Page" in the "Content Head" region

    And I click "For Students" in the "First sidebar" region
    And I should see "Private Pages" in the "First sidebar" region
    And I should see a ".block-menu" element
    And I should see "For Students" in the "Content Head" region

    And I click "For Staff" in the "First sidebar" region
    And I should see "Private Pages" in the "First sidebar" region
    And I should see a ".block-menu" element
    And I should see "For Staff" in the "Content Head" region

  @api @safe
  Scenario: Check administrator can view Private Pages Section
    Given I am logged in as a user with the "administrator" role
    And I am on "private"
    Then I should see 1 ".node-type-stanford-private-page" element

  @safe
  Scenario: Anonymous users can not see private pages
    Given I am on "private"
    Then I should not see an ".node-type-stanford-private-page" element
