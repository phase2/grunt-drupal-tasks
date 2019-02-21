@api
Feature: Stanford Banner bean Type
  In order to ensure that the banner bean exists
  As an administrator
  I want to check that the Stanford Banner bean types module is working correctly

  Background:
    Given I am logged in as a user with the "administrator" role

  @safe
  Scenario: Stanford Banner Type Exists
    Given I am on "block/add"
    Then I should see the link "stanford_banner" in the "Content" region

  @safe
  Scenario: Stanford Banner Type Fields Exist
    Given I am on "admin/structure/block-types/manage/stanford-banner/fields"
    Then I should see "Label"
    Then I should see "Title"
    Then I should see "field_s_image_info"
    Then I should see "view_mode"

  @safe
  Scenario: Stanford Banner Type Display Modes Exist
    Given I am on "admin/structure/block-types/manage/stanford-banner/display"
    # And default display is set to something
    Then I should see "View mode: Banner 9 Column"
    # View modes
    Then the "Banner 12 Column" checkbox should be checked
    Then the "Banner 12 Column Tall" checkbox should be checked
    Then the "Banner 9 Column" checkbox should be checked
    Then the "Banner Full Width Short" checkbox should be checked

  @safe
  Scenario: Stanford Banner Type Display Mode 12 Column
    Given I am on "admin/structure/block-types/manage/stanford-banner/display/stanford_12_col_banner"
    Then I should see "View mode: Banner 12 Column"

  @safe
  Scenario: Stanford Banner Type Display Mode 12 Column Tall
    Given I am on "admin/structure/block-types/manage/stanford-banner/display/stanford_12_col_banner_tall"
    Then I should see "View mode: Banner 12 Column Tall"

  @safe
  Scenario: Stanford Banner Type Display Mode 9 Column
    Given I am on "admin/structure/block-types/manage/stanford-banner/display/stanford_9_col_banner"
    Then I should see "View mode: Banner 9 Column"

  @safe
  Scenario: Stanford Banner Type Display Mode Full Width Short
    Given I am on "admin/structure/block-types/manage/stanford-banner/display/stanford_full_width_banner_short"
    Then I should see "View mode: Banner Full Width Short"

  @dev @destructive
  Scenario: Create stanford banner block
    And I am on "block/add/stanford-banner"
    Then I fill in "edit-label" with "Behat Banner Block"
    Then I fill in "edit-title" with "Behat Banner Block"
    Then I attach the file "features/stanford_bean_types/img/ooooaaaahhh.jpg" to "files[field_s_image_info_und_0_field_s_image_image_und_0]"
    Then I fill in "field_s_image_info[und][0][field_s_image_credits][und][0][value]" with "This is the credits"
    Then I fill in "field_s_image_info[und][0][field_s_image_source_info][und][0][value]" with "This is the source"
    Then I fill in "field_s_image_info[und][0][field_s_image_caption][und][0][value]" with "This is the caption"
    Then I select "Banner 12 Column" from "edit-view-mode"
    Then I select "Banner 12 Column Tall" from "edit-view-mode"
    Then I select "Banner 9 Column" from "edit-view-mode"
    Then I select "Banner Full Width Short" from "edit-view-mode"
    Then I select "Default" from "edit-view-mode"
    Then I press "Save"
    Then I should see "stanford_banner Behat Banner Block has been created."
    Then I should see "This is the caption"
    Then I should see "Behat Banner Block"
    Then I should see 1 ".field-name-field-s-image-image" element
    Then I should see 1 ".field-name-field-s-image-image img" element
    Then I click "Delete Block"
    Then I press "Delete"
    Then I should see "stanford_banner Behat Banner Block has been deleted."
