@api
Feature: Stanford Paragraph Types Textarea Simple
  In order to ensure that the Stanford Paragraphs Types installs properly
  As an end user
  I want to verify the display of content.

  @safe
  Scenario: Check for Textarea simple paragraph type
    Given I am logged in as a user with the "administrator" role
    Then I am on "admin/structure/paragraphs/p_wysiwyg_simple/fields"
    And I should see "field_p_ws_body"
    And I should see "field_p_ws_image"

    Then I am on "admin/structure/paragraphs/p_wysiwyg_simple/display/default"
    And I want to validate select field option "fields[field_p_ws_body][type]" default value is "text_default"
    And I want to validate select field option "fields[field_p_ws_body][parent]" default value is "group_p_ws_style"
    And I want to validate select field option "fields[field_p_ws_image][type]" default value is "hidden"
