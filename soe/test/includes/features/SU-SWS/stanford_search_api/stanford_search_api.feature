Feature: Stanford Search API
  In order to ensure end users on the CAW website can search and find content
  As an anonymous user
  I want to check that I can use the search form and block

# Search block in top right
@api @live
Scenario: Search block is visible to anonymous users
  Given I am on the homepage
  Then I should see a "#stanford-search-api-search-block-form" element in the "Search Box" region

# Search page exists with default text and search input
@api @live
Scenario: Search page is visible to anonymous users
  Given I am on "search/content"
  Then I should see a "#edit-search-api-views-fulltext" element in the "Content Body" region
  And I should see "Enter text in the keyword search field to begin your content search" in the "Content Body" region

# Search something lame with no results and have helpful text
@api @live
Scenario: Search results with zero results provides helpful text
  Given I am on "search/content"
  When I fill in "Keyword search" with "Purple mom key dish water"
  And I press "Search"
  Then I should see "Your search did not yield any results" in the "Content Body" region

# Search for results
@api @live
Scenario: Search results with multiple results provides helpful text
  Given I am on "search/content"
  When I fill in "Keyword search" with "university"
  And I press "Search"
  Then I should see at least one ".views-row" element in the "Content Body" region

# Search for results and have facets available
@api @live
Scenario: Search results with multiple results provides helpful text
  Given I am on "search/content"
  When I fill in "Keyword search" with "university"
  And I press "Search"
  Then I should see "Filter by content type" in the "First sidebar" region

# Search for results and have facets then click a facet and check results
#
#
#
#
#

# Search facet blocks are displaying with checkbox widget
@api @live
Scenario: Search facet blocks are displaying with checkbox widget
  Given I am on "search/content"
  When I fill in "Keyword search" with "university"
  And I press "Search"
  Then I should see "Filter by content type" in the "First sidebar" region
  And I should see at least one "input[type='checkbox']" element in the "First sidebar" region

# Search facet links in view results work as facets

# Search results have highlighting

# Search with many results has pager after 25 items

# Search autocomplete is displaying results
