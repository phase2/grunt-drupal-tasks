Feature: Stanford Page
  In order to ensure that the Stanford Page displays properly
  As an end user
  I want to verify the display of content.

  @api @safe
  Scenario: Check for fields on manage fields page
    Given I am logged in as a user with the "administrator" role
    And I am on "admin/structure/types/manage/stanford_page/fields"
    Then I should see "Title"
    And I should see "field_s_image_info"
    And I should see "body"
    And I should see "field_s_page_image_insert"
    And I should see "field_s_page_file"
    Then I am on "admin/structure/types/manage/stanford_page/display"
    And I should see "Postcard"
    And I should see "Postcard Image"
    And I should see "Postcard Content"
    #And I should see "View mode: Large Scaled"
    Then I want to validate select field option "edit-fields-field-s-page-file-type" default is "Generic file"

  @api @dev @destructive 
  Scenario: Add Stanford Page
    Given I am logged in as a user with the "administrator" role
    And I am on "node/add/stanford-page"
    Then I should see the heading "Create Stanford Page" in the "Branding" region
    And the "Text format" field should contain "content_editor_text_format"
    Then I should see "Source Info" in the "Content" region
    Then I fill in "edit-title" with "Foo Stanford Page"
    Then I fill in "body[und][0][value]" with "Hello, this is a nice body"
    And I press the "Save" button
    Then I should see "Stanford Page Foo Stanford Page has been created"
    And I should be on "foo-stanford-page"
    And I should see "Hello, this is a nice body"

  @api @safe
  Scenario: Check for display on manage pages view
    Given I am logged in as a user with the "administrator" role
    And I am on "admin/structure/views"
    Then I should see "Stanford Page: Manage"
