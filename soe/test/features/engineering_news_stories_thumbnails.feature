Feature: Ensure the news stories have thumbnails
  In order to ensure that news stories have thumbnails
  As a Site User
  I want to be able to view thumbnails on news stories

  @safe
  Scenario: Verify users can view the images on the faculty profiles
    Given I am on "news/recent-news"
    Then I should see "School News" in the "Main Top" region
    And I should see 1 or more ".view-content" elements
    And I should see 1 or more ".postcard-content" elements
