Feature: Stanford Easy WYSIWYG CSS
  In order to ensure that the WYSIWYG is getting the css from the theme
  As an administrative user
  I want to ensure the the WYSIWYG Profiles are using the easy setting

  @api @safe
  Scenario: Help Page is available
    Given I am logged in as a user with the "administrator" role
    And I am on "admin/help/stanford_easy_wysiwyg_css"
    Then I should see "Your WYSIWYG fields now should show the same CSS styles as your front-end theme"

  @api @safe
  Scenario: Help Page is available
    Given I am logged in as a user with the "administrator" role
    And I am on "admin/config/content/wysiwyg/profile/content_editor_text_format/edit"
    Then I want to validate select field option "edit-css-setting" default is "All CSS from default front-end theme"

