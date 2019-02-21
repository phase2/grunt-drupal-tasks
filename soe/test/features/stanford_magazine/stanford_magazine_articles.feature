Feature: Stanford Magazine Articles
  In order to ensure the article listing pages for the are correct.
  As an anonymous user I want to:


  @safe
  Scenario: Verify order of articles on the landing page
    Given I am on "magazine/artificial-intelligence"
    Then I should see all timestamps for ".mag-article-date" in "descending" order

  @safe
  Scenario: Verify order of articles on the landing page
    Given I am on "magazine/environment"
    Then I should see all timestamps for ".mag-article-date" in "descending" order

  @safe
  Scenario: Verify order of articles on the landing page
    Given I am on "magazine/technology-society"
    Then I should see all timestamps for ".mag-article-date" in "descending" order

  @safe
  Scenario: Verify order of articles on the landing page
    Given I am on "magazine/computation-data"
    Then I should see all timestamps for ".mag-article-date" in "descending" order

  @safe
  Scenario: Verify order of articles on the landing page
    Given I am on "magazine/transportation-robotics"
    Then I should see all timestamps for ".mag-article-date" in "descending" order

  @safe
  Scenario: Verify order of articles on the landing page
    Given I am on "magazine/electronics-networking"
    Then I should see all timestamps for ".mag-article-date" in "descending" order

  @safe
  Scenario: Verify order of articles on the landing page
    Given I am on "magazine/materials"
    Then I should see all timestamps for ".mag-article-date" in "descending" order

  @safe
  Scenario: Verify order of articles on the landing page
    Given I am on "magazine/energy"
    Then I should see all timestamps for ".mag-article-date" in "descending" order

  @safe
  Scenario: Verify order of articles on the landing page
    Given I am on "magazine/security"
    Then I should see all timestamps for ".mag-article-date" in "descending" order

  @safe
  Scenario: Verify order of articles on the health page
    Given I am on "magazine/health"
    Then I should see all timestamps for ".mag-article-date" in "descending" order

  @safe
  Scenario: Verify order of articles on the landing page
    Given I am on "magazine"
    Then I should see all timestamps for ".mag-article-date" in "descending" order

  @safe
  Scenario: Verify order of articles on the all page
    Given I am on "magazine/all"
    Then I should see all timestamps for ".mag-article-date" in "descending" order
