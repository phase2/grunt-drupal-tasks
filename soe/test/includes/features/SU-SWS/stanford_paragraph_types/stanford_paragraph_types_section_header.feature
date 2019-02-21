@api
Feature: Stanford Paragraph Types Dynamic
  In order to ensure that the Stanford Paragraphs Types installs properly
  As an end user
  I want to verify the display of content.

  @safe
  Scenario: Check for section header paragraph type
    Given I am logged in as a user with the "administrator" role
    Then I am on "admin/structure/paragraphs/p_section_header/fields"
    And I should see "field_p_section_color"
    And I should see "field_p_section_heading"

    Then I am on "admin/structure/paragraphs/p_section_header/display/default"
    And I want to validate select field option "fields[field_p_section_color][type]" default value is "hidden"
    And I want to validate select field option "fields[field_p_section_heading][type]" default value is "text_default"
    And I want to validate select field option "fields[field_p_section_heading][parent]" default value is "group_p_section_header"

    Then I am on "admin/structure/paragraphs/p_section_header/display/paragraphs_editor_preview"
    And I want to validate select field option "fields[field_p_section_color][type]" default value is "hidden"
    And I want to validate select field option "fields[field_p_section_heading][type]" default value is "hidden"
