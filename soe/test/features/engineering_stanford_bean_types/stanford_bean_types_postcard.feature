@api
Feature: Stanford postcard bean Type
  In order to ensure that the postcard bean exists
  As an administrator
  I want to check that the Stanford postcard bean types module is working correctly

  Background:
    Given I am logged in as a user with the "administrator" role

  @safe
  Scenario: Stanford postcard type exists
    And I am on "block/add"
    Then I should see the link "stanford_postcard" in the "Content" region

  @safe
  Scenario: Stanford Postcard Block Type Fields Exist
    Given I am on "admin/structure/block-types/manage/stanford-postcard/fields"
    Then I should see "Label"
    Then I should see "Title"
    Then I should see "field_s_image_info"
    Then I should see "field_s_postcard_body"
    Then I should see "field_s_postcard_image_insert"
    Then I should see "field_s_postcard_file"
    Then I should see "field_s_postcard_link"
    Then I should see "view_mode"

  @safe
  Scenario: Stanford Postcard block custom display settings
    Given I am on "admin/structure/block-types/manage/stanford-postcard/display"
    # View modes
    Then the "Header 3 Column" checkbox should be checked
    Then the "Header 4 Column" checkbox should be checked
    Then the "Photo Landscape 6 Column" checkbox should be checked
    Then the "Single Centered Button" checkbox should be checked

  @safe
  Scenario: Stanford Postcard block custom display Single Centered Button
    Given I am on "admin/structure/block-types/manage/stanford-postcard/display/single_centered_button"
    Then I should see "Body"

  @safe
  Scenario: Stanford Postcard block custom display Header 4 column
    Given I am on "admin/structure/block-types/manage/stanford-postcard/display/stanford_4_col_header"
    Then I should see "View mode: Header 4 Column"
    Then I should see "Postcard"
    Then I should see "group_s_postcard"
    Then I should see "Postcard Image"
    Then I should see "group_s_postcard_image"
    Then I should see "Key Image"
    Then I should see "Postcard Content"
    Then I should see "group_s_postcard_content"
    Then I should see "Body"
    Then I should see "File Insert"
    Then I should see "Read More Link"

  @safe
  Scenario: Stanford Postcard block custom display Header 3 column
    Given I am on "admin/structure/block-types/manage/stanford-postcard/display/stanford_3_col_header"
    Then I should see "View mode: Header 3 Column"
    Then I should see "Postcard"
    Then I should see "group_s_postcard"
    Then I should see "Postcard Image"
    Then I should see "group_s_postcard_image"
    Then I should see "Key Image"
    Then I should see "Postcard Content"
    Then I should see "group_s_postcard_content"
    Then I should see "Body"
    Then I should see "File Insert"
    Then I should see "Read More Link"

  @safe
  Scenario: Stanford Postcard block custom display Header 4 column
    Given I am on "admin/structure/block-types/manage/stanford-postcard/display/stanford_4_col_header"
    Then I should see "View mode: Header 4 Column"
    Then I should see "Postcard"
    Then I should see "group_s_postcard"
    Then I should see "Postcard Image"
    Then I should see "group_s_postcard_image"
    Then I should see "Key Image"
    Then I should see "Postcard Content"
    Then I should see "group_s_postcard_content"
    Then I should see "Body"
    Then I should see "File Insert"
    Then I should see "Read More Link"

  @safe
  Scenario: Stanford Postcard block custom display Photo Landscape 6 Column
    Given I am on "admin/structure/block-types/manage/stanford-postcard/display/stanford_6_col_photo_landscape"
    Then I should see "View mode: Photo Landscape 6 Column"
    Then I should see "Postcard"
    Then I should see "group_s_postcard"
    Then I should see "Postcard Image"
    Then I should see "group_s_postcard_image"
    Then I should see "Key Image"
    Then I should see "Postcard Content"
    Then I should see "group_s_postcard_content"
    Then I should see "Body"
    Then I should see "File Insert"
    Then I should see "Read More Link"

  @safe
  Scenario: View modes options on create block form
    And I am on "block/add/stanford-postcard"
    Then I select "Header 3 Column" from "View Mode"
    Then I select "Header 4 Column" from "View Mode"
    Then I select "Photo Landscape 6 Column" from "View Mode"

  @dev @destructive
  Scenario: Create stanford postcard block
    And I am on "block/add/stanford-postcard"
    Then I fill in "edit-label" with "Behat Postcard Block"
    Then I fill in "edit-title" with "Behat Postcard Block"
    Then I attach the file "features/img/ooooaaaahhh.jpg" to "edit-field-s-image-info-und-0-field-s-image-image-und-0-upload"
    Then I fill in "field_s_image_info[und][0][field_s_image_source_info][und][0][value]" with "This is the source"
    Then I fill in "field_s_image_info[und][0][field_s_image_caption][und][0][value]" with "This is the caption"
    Then I fill in "field_s_postcard_body[und][0][value]" with "This is the body content"
    Then I attach the file "features/img/ooooaaaahhh.jpg" to "files[field_s_postcard_image_insert_und_0]"
    Then I fill in "field_s_postcard_link[und][0][title]" with "This is the read more link title"
    Then I fill in "field_s_postcard_link[und][0][url]" with "http://www.stanford.edu"
    Then I select "Header 4 Column" from "edit-view-mode"
    Then I press "Save"
    Then I should see "stanford_postcard Behat Postcard Block has been created."
  #  Then I should see "This is the caption" <- caption is no longer getting displayed with the new image format
    Then I should see "This is the body content"
    Then I should see "Behat Postcard Block"
    Then I should see "This is the read more link title"
    Then I should see 1 ".field-name-field-s-image-image" element
    Then I should see 1 ".field-name-field-s-image-image img" element
#    Then I should see 1 ".view-mode-stanford-4-col-header" element <- we changed the image format
    Then I should see 1 ".view-mode-header_370x170" element
    Then I click "Delete Block"
    Then I press "Delete"
    Then I should see "stanford_postcard Behat Postcard Block has been deleted."
