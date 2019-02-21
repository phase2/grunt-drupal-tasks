Feature: NoBots
  In order to ensure that the nobots feature blocks web crawlers
  As a robot to the site I want to be sent a no index header.

  @dev
  Scenario: As a robot to the site I want to be sent a no index header
    Given I am on the homepage
    Then the response header "X-Robots-Tag" should contain "noindex,nofollow,noarchive"
