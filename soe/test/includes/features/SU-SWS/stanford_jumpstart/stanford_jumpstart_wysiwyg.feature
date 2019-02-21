Feature: Stanford Sites Jumpstart WYSIWYG
  In order to ensure that functionality of the module
  As an administrative user
  I want to ensure the filter format and wysiwyg is configured

  @api @safe
  Scenario: Check permissions
    Given I run drush "rls" "--filter='show format tips'"
    And drush output should contain "administrator"
    And drush output should contain "authenticated user"
    Then I run drush "rls" "--filter='show more format tips link'"
    And drush output should contain "administrator"
    And drush output should contain "authenticated user"

  @api @safe
  Scenario: Check if filter format exists and is configured.
    Given I am logged in as a user with the "administrator" role
    And I am on "admin/config/content/formats/content_editor_text_format"
    Then I should see the heading "Content Editor Text Format"
    And the "filters[wysiwyg][status]" checkbox should be checked
    And the "filters[filter_htmlcorrector][status]" checkbox should be checked
    And the "filters[pathologic][status]" checkbox should be checked

  @api @safe
  Scenario: Check if wysiwyg is configured for filter format.
    Given I am logged in as a user with the "administrator" role
    And I am on "admin/config/content/wysiwyg/profile/content_editor_text_format/edit"
    Then I should see the heading "CKEditor profile for Content Editor Text Format"
    # Basic Setup.
    And the "default" checkbox should be checked
    And the "user_choose" checkbox should not be checked
    And the "show_toggle" checkbox should be checked
    # Buttons and Plugins
    And the "buttons[default][Bold]" checkbox should be checked
    And the "buttons[default][Italic]" checkbox should be checked
    And the "buttons[default][BulletedList]" checkbox should be checked
    And the "buttons[default][NumberedList]" checkbox should be checked
    And the "buttons[default][Outdent]" checkbox should be checked
    And the "buttons[default][Indent]" checkbox should be checked
    And the "buttons[default][Undo]" checkbox should be checked
    And the "buttons[default][Redo]" checkbox should be checked
    And the "buttons[default][Link]" checkbox should be checked
    And the "buttons[default][Unlink]" checkbox should be checked
    And the "buttons[default][Anchor]" checkbox should be checked
    And the "buttons[default][HorizontalRule]" checkbox should be checked
    And the "buttons[default][Cut]" checkbox should be checked
    And the "buttons[default][Copy]" checkbox should be checked
    And the "buttons[default][PasteFromWord]" checkbox should be checked
    And the "buttons[default][RemoveFormat]" checkbox should be checked
    And the "buttons[default][SpecialChar]" checkbox should be checked
    And the "buttons[default][Format]" checkbox should be checked
    And the "buttons[default][Styles]" checkbox should be checked
    And the "buttons[default][Table]" checkbox should be checked
    And the "buttons[default][SpellChecker]" checkbox should be checked
    # Editor Appearance
    And I want to validate select field option "toolbar_loc" default is "Top"
    And I want to validate select field option "toolbar_align" default is "Left"
    And I want to validate select field option "path_loc" default is "Bottom"
    And the "resizing" checkbox should be checked
    # Cleanup and Output
    And the "verify_html" checkbox should be checked
    And the "preformatted" checkbox should not be checked
    And the "convert_fonts_to_spans" checkbox should be checked
    And the "remove_linebreaks" checkbox should be checked
    And the "apply_source_formatting" checkbox should be checked
    And the "paste_auto_cleanup_on_paste" checkbox should be checked
    # CSS
    And I should see "Button Link=a.btn"
    And I should see "More Link=a.more-link"
    And I should see "Descriptor=p.descriptor"
    And I should see "Summary Paragraph=p.summary"
    And I should see "Image Right=p.float-right"
    And I should see "Image Left=p.float-left"
    And I should see "Infotext=p.infotext"
    And I should see "Caption=p.caption"
    And I should see "Credits=p.credits"



    
