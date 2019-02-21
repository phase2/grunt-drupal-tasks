Feature: XML_sitemap
  Verify XML_SiteMap functionality

  @api @live
  Scenario: XML Sitemap
    Given I am logged in as a user with the "administrator" role
    And I run cron
    When I go to "/sitemap.xml"
    Then I should get a "200" HTTP response

  @api @dev
  Scenario: XML Sitemap
    Given I am logged in as a user with the "administrator" role
    And I run cron
    When I go to "/sitemap.xml"
    Then I should get a "404" HTTP response