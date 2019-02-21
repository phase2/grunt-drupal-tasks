Feature: Courses page 
  In order to ensure that the Courses page content is visible
  As an end user
  I want to check for the existence of the page

  @deploy
  Scenario: Check content of the research page
    Given I am on "courses"
    Then I should see "This is your Courses page" in the "Content Body" region
    And I should see the link "View Explore Courses" in the "Content Body" region
    
