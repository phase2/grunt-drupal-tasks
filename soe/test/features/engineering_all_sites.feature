Feature: Every page will be checked for the following regions, elements and functions
  In order to ensure that the content on all sites exist,
  As an end user
  I want to check whether the content exists

  @safe
  Scenario: Verify that the logo exists on the homepage
    Given I am on the homepage
    Then I should see a "#logo" element
    Then I should see a "#name-and-slogan" element

  @safe
  Scenario: See the nav bar region
    Given I am on the homepage
    Then I should see an "#main-nav" element

  @safe
  Scenario: See the li element in the nav bar region
    Given I am on the homepage
    Then I should see the "li" element in the "Main Navigation" region

  @safe
  Scenario: See the search block
    Given I am on the homepage
    Then I should see an "#block-stanford-search-api-search-api-search-block" element

  @safe
  Scenario: See the content body region
    Given I am on the homepage
    Then I should see an "#content-body" element

  @safe
  Scenario: See the footer region
    Given I am on the homepage
    Then I should see an "#footer" element

  @safe
  Scenario: Verify that /user page has the appropriate content
    Given I am on "user"
    Then I should see the text "Log in"

  @safe
  Scenario: Verify that entering a search yields the correct result
    Given I am on the homepage
    Then I should see a "#stanford-search-api-search-block-form" element
    When I enter "purple monkey dishwasher" for "Search"
    And I press the "Search" button
    And I should see "Search" in the "Content Head" region
    And I should see "Keyword search"
