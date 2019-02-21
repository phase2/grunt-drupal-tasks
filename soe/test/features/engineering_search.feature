Feature: Ensure the search functionality is working correctly
  In order to ensure the search is working
  As a Site User
  I want to be able to search for any content in the site

  @safe
  Scenario: Verify users can search for any content
    Given I am on "search/content"
    Then I should see "Search" in the "Main Content" region
    When I enter "lorem" for "Keyword search"
    And I press the "Apply" button
    Then I should be on "search/content?search_api_views_fulltext=lorem"
