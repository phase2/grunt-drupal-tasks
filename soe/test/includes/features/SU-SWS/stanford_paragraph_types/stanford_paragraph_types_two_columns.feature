@api
Feature: Stanford Paragraph Two Columns
  In order to ensure that the Stanford Paragraphs Types installs properly
  As an end user
  I want to verify the display of content.

  @safe
  Scenario: Check for two columns paragraph type
    Given I am logged in as a user with the "administrator" role
    Then I am on "admin/structure/paragraphs/p_two_columns/fields"
    And I should see "field_p_2p_body"

    Then I am on "admin/structure/paragraphs/p_two_columns/display/default"
    And I want to validate select field option "fields[field_p_2p_body][type]" default value is "text_default"
