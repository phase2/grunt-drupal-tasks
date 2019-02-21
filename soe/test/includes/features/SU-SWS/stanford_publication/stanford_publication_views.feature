Feature: Publication views
  In order to verify the functionality of the publication views
  As an end user
  I want to check for the existence of publication content on views pages

  @safe
  Scenario: Filter publications by title
    Given I am on "publications"
    Then I should see "Have something to add?" in the "Content Body" region
    Then I should see "Filter by title" in the "First sidebar" region
    When I fill in "Filter by title" with "e"
    And I press "Go"
    Then I should see "Search Publications" in the "Content Head" region
    Then I should see "Filter by title" in the "First sidebar" region

   @deploy
  Scenario: Filter publications by title
    Given I am on "publications"
    When I fill in "Filter by title" with "book title two"
    And I press "Go"
    Then I should see "Sample Publication: Book Title Two" in the "Content Body" region

   @deploy
  Scenario: Filter publications by author
    Given I am on "publications"
    When I fill in "Filter by author" with "Marvin C. Ferrell"
    And I press "Go"
    Then I should see "Marvin C. Ferrell" in the "Content Body" region

   @deploy
  Scenario: Filter publications by type
    Given I am on "publications"
    When I select "Book" from "Filter by type"
    And I press "Go"
    Then I should see "Sample Publication: Book Title Two" in the "Content Body" region

   @deploy
  Scenario: Click through to publication
    Given I am on "publications"
    When I click "Sample Publication: Book Title Two" in the "Content Body" region
    Then I should see "This is a publication." in the "Content Body" region

   @deploy
  Scenario: Publication showing correct image size
    Given I am on "publications/sample-publication-book-title-two"
    Then I should see a ".view-mode-stanford-large-scaled" element

  @api @deploy
  Scenario: Publication Type Terms
    Given I am logged in as a user with the "administrator" role
    And I am on "admin/structure/taxonomy_manager/voc/publication_type"
    Then I should see "Book" in the "Content Body" region
    And I should see "Journal Article" in the "Content Body" region
