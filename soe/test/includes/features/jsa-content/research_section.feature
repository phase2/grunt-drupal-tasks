Feature: Research Section
  In order to ensure that the Jumpstart Engineering Research section content is visible when expected
  As an end user
  I want to check for the existence of page and menu content

  @deploy
  Scenario: Check that the correct menu items exist in research section of a newly deployed site.
    Given I am on "research"
    Then I should see "This is your Research page" in the "Content Body" region
    Then I should see "Research Overview" in the "First sidebar" region
    Then I should see "Research Example" in the "First sidebar" region
    Then I should see "Project Example" in the "First sidebar" region

  @deploy
  Scenario: Check that the correct pages exist in research section of a newly deployed site.
    Given I am on the homepage
    And I click "Research" in the "Main Navigation" region
    Then I should see "This is your Research" in the "Content Body" region
    And I click "Research Example" in the "First sidebar" region
    Then I should see "This is an example of a research" in the "Content Body" region
    And I click "Project Example" in the "First sidebar" region
    Then I should see "This is an example of a research" in the "Content Body" region

  @launch
  Scenario: Check that the placeholder content does not exist in the research section of a ready to launch site.
    Given I am on "research/overview"
    Then I should not see "This is your Research" in the "Content Body" region
    And I should not see "Research Example" in the "First sidebar" region
    And I should not see "Project Example" in the "First sidebar" region
