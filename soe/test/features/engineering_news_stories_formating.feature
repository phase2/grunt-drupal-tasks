Feature: Ensure the news story is formatting correctly
  In order to ensure that news stories are formatting correctly
  As a Site User
  I want to be able to format news stories

  @safe
  Scenario: Verify users can view the school news stories
    Given I am on "news/school-news"
    Then I should see "School News" in the "Main Top" region
    And I should see 1 or more ".view-content" elements
    When I click on the element with css selector ".news-image a"
    Then I should see 1 or more ".field-items" elements
    And I should see 1 or more ".field-item" elements
    And I should see "See more news"
