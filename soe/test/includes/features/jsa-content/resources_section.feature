Feature: Resources Section
  In order to ensure that the Jumpstart Engineering Resources section content is visible when expected
  As an end user
  I want to check for the existence of page and menu content

  @deploy
  Scenario: Check that the correct menu items exist in resources section of a newly deployed site.
    Given I am on "resources/overview"
    Then I should see "This is your Resources" in the "Content Body" region
    Then I should see "Resources Overview" in the "First sidebar" region
    Then I should see "Software Resources" in the "First sidebar" region
    Then I should see "References" in the "First sidebar" region

  @deploy
  Scenario: Check that the correct pages exist in research section of a newly deployed site.
    Given I am on the homepage
    And I click "Resources" in the "Main Navigation" region
    Then I should see "This is your Resources" in the "Content Body" region
    And I click "Software Resources" in the "First sidebar" region
    Then I should see "This is an example of a software resources page" in the "Content Body" region
    And I click "References" in the "First sidebar" region
    Then I should see "This is an example of a references page" in the "Content Body" region


  @launch
  Scenario: Check that the placeholder content does not exist in the resources section of a ready to launch site.
    Given I am on "resources/overview"
    Then I should not see "This is your Resources" in the "Content Body" region

  @launch
  Scenario: Check that the placeholder content does not exist in the software resources section of a ready to launch site.
    Given I am on "resources/software"
    Then I should not see "This is an example of a software resources page" in the "Content Body" region

  @launch
  Scenario: Check that the placeholder content does not exist in the software references section of a ready to launch site.
    Given I am on "resources/references"
    Then I should not see "This is an example of a references page" in the "Content Body" region
