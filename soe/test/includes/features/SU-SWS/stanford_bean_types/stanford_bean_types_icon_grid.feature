@api
Feature: Stanford Icon Grid bean Type
  In order to ensure that the Icon Grid bean exists
  As an administrator
  I want to check that the Stanford Icon Grid bean types module is working correctly

  @safe
  Scenario: Stanford Icon Grid type exists
    Given I am logged in as a user with the "administrator" role
    And I am on "block/add"
    Then I should see the link "stanford_social_media_connect" in the "Content" region

  @safe
  Scenario: Icon Grid Block Type Fields Exist
    Given I am logged in as a user with the "administrator" role
    Then I am on "admin/structure/block-types/manage/stanford_icon_grid/fields"
    And I should see "field_s_icon_ext_columns"

    Then I am on "admin/structure/block-types/manage/stanford_icon_grid/display/default"
    And I want to validate select field option "fields[field_s_icon_ext_columns][type]" default value is "field_collection_view"

    Then I am on "admin/structure/field-collections/field_s_icon_ext_columns/fields"
    And I should see "field_s_icon_ext_columns_bg_colo"
    And I should see "field_s_icon_ext_columns_caption"
    And I should see "field_s_icon_ext_columns_fa_icon"
    And I should see "field_s_icon_ext_columns_links"
    And I should see "field_s_icon_ext_columns_style"
    And I should see "field_s_icon_ext_columns_text"
    And I should see "field_s_icon_ext_columns_title"
    And I should see "field_s_icon_ext_columns_up_icon"

    Then I am on "admin/structure/field-collections/field_s_icon_ext_columns/display/default"
    And I want to validate select field option "fields[field_s_icon_ext_columns_bg_colo][type]" default value is "hidden"
    And I want to validate select field option "fields[field_s_icon_ext_columns_caption][type]" default value is "text_default"
    And I want to validate select field option "fields[field_s_icon_ext_columns_fa_icon][type]" default value is "fontawesome_icon_formatter"
    And I want to validate select field option "fields[field_s_icon_ext_columns_links][type]" default value is "link_default"
    And I want to validate select field option "fields[field_s_icon_ext_columns_links][parent]" default value is "group_s_more_link_style"
    And I want to validate select field option "fields[field_s_icon_ext_columns_style][type]" default value is "hidden"
    And I want to validate select field option "fields[field_s_icon_ext_columns_text][type]" default value is "hidden"
    And I want to validate select field option "fields[field_s_icon_ext_columns_title][type]" default value is "text_default"
    And I want to validate select field option "fields[field_s_icon_ext_columns_title][parent]" default value is "group_s_title_styles"
    And I want to validate select field option "fields[field_s_icon_ext_columns_up_icon][type]" default value is "hidden"

    Then I am on "admin/structure/field-collections/field_s_icon_ext_columns/display/stanford_block"
    And I want to validate select field option "fields[field_s_icon_ext_columns_bg_colo][type]" default value is "hidden"
    And I want to validate select field option "fields[field_s_icon_ext_columns_caption][type]" default value is "text_default"
    And I want to validate select field option "fields[field_s_icon_ext_columns_fa_icon][type]" default value is "hidden"
    And I want to validate select field option "fields[field_s_icon_ext_columns_links][type]" default value is "link_default"
    And I want to validate select field option "fields[field_s_icon_ext_columns_links][parent]" default value is "group_more_link"
    And I want to validate select field option "fields[field_s_icon_ext_columns_style][type]" default value is "hidden"
    And I want to validate select field option "fields[field_s_icon_ext_columns_text][type]" default value is "hidden"
    And I want to validate select field option "fields[field_s_icon_ext_columns_title][type]" default value is "text_default"
    And I want to validate select field option "fields[field_s_icon_ext_columns_title][parent]" default value is "group_title_styles"
    And I want to validate select field option "fields[field_s_icon_ext_columns_up_icon][type]" default value is "image"

    Then I am on "admin/structure/field-collections/field_s_icon_ext_columns/display/stanford_list"
    And I want to validate select field option "fields[field_s_icon_ext_columns_bg_colo][type]" default value is "hidden"
    And I want to validate select field option "fields[field_s_icon_ext_columns_caption][type]" default value is "text_default"
    And I want to validate select field option "fields[field_s_icon_ext_columns_fa_icon][type]" default value is "hidden"
    And I want to validate select field option "fields[field_s_icon_ext_columns_links][type]" default value is "link_default"
    And I want to validate select field option "fields[field_s_icon_ext_columns_links][parent]" default value is "group_read_more"
    And I want to validate select field option "fields[field_s_icon_ext_columns_style][type]" default value is "hidden"
    And I want to validate select field option "fields[field_s_icon_ext_columns_text][type]" default value is "text_default"
    And I want to validate select field option "fields[field_s_icon_ext_columns_title][type]" default value is "text_default"
    And I want to validate select field option "fields[field_s_icon_ext_columns_title][parent]" default value is "group_title_style"
    And I want to validate select field option "fields[field_s_icon_ext_columns_up_icon][type]" default value is "hidden"


  @dev @destructive
  Scenario: Create Icon Grid connect block
    Given I am logged in as a user with the "administrator" role
    And I am on "block/add/stanford-icon-grid"
    Then I fill in "edit-label" with "Behat Icon Grid Block"
    And I fill in "edit-title" with "Behat Icon Grid Block"

    # Column 1
    Then I Select the "field_s_icon_ext_columns[und][0][field_s_icon_ext_columns_style][und]" radio button with "icon" value
    And I select "Map" from "field_s_icon_ext_columns[und][0][field_s_icon_ext_columns_fa_icon][und][0][icon]"
    And I select "Dark Taupe" from "field_s_icon_ext_columns[und][0][field_s_icon_ext_columns_bg_colo][und]"
    And I fill in "field_s_icon_ext_columns[und][0][field_s_icon_ext_columns_title][und][0][value]" with "Column #1"
    And I fill in "field_s_icon_ext_columns[und][0][field_s_icon_ext_columns_links][und][0][title]" with "Google"
    And I fill in "field_s_icon_ext_columns[und][0][field_s_icon_ext_columns_links][und][0][url]" with "google.com"
    Then I click on the element with css selector "#edit-field-s-icon-ext-columns-und-0-field-s-icon-ext-columns-links-und-add-more"
    And I fill in "field_s_icon_ext_columns[und][0][field_s_icon_ext_columns_links][und][1][title]" with "Google"
    And I fill in "field_s_icon_ext_columns[und][0][field_s_icon_ext_columns_links][und][1][url]" with "google.com"
    Then I click on the element with css selector "#edit-field-s-icon-ext-columns-und-add-more"

   # Column 2
    Then I Select the "field_s_icon_ext_columns[und][1][field_s_icon_ext_columns_style][und]" radio button with "image" value
    And I attach the file "features/stanford_bean_types/img/bike icon.png" to "files[field_s_icon_ext_columns_und_1_field_s_icon_ext_columns_up_icon_und_0]"
    And I select "Cool Gray" from "field_s_icon_ext_columns[und][1][field_s_icon_ext_columns_bg_colo][und]"
    And I fill in "field_s_icon_ext_columns[und][1][field_s_icon_ext_columns_title][und][0][value]" with "Column #2"
    And I fill in "field_s_icon_ext_columns[und][1][field_s_icon_ext_columns_links][und][0][title]" with "Facebook"
    And I fill in "field_s_icon_ext_columns[und][1][field_s_icon_ext_columns_links][und][0][url]" with "facebook.com"
    Then I click on the element with css selector "#edit-field-s-icon-ext-columns-und-add-more"

    # Column 3
    Then I Select the "field_s_icon_ext_columns[und][2][field_s_icon_ext_columns_style][und]" radio button with "text" value
    And I select "Light Taupe" from "field_s_icon_ext_columns[und][2][field_s_icon_ext_columns_bg_colo][und]"
    And I fill in "field_s_icon_ext_columns[und][2][field_s_icon_ext_columns_text][und][0][value]" with "9090"
    And I fill in "field_s_icon_ext_columns[und][2][field_s_icon_ext_columns_title][und][0][value]" with "Column #3"
    And I fill in "field_s_icon_ext_columns[und][2][field_s_icon_ext_columns_links][und][0][title]" with "Facebook"
    And I fill in "field_s_icon_ext_columns[und][2][field_s_icon_ext_columns_links][und][0][url]" with "facebook.com"

    Then I press "Save"
    Then I should see "Invalid background color choice"
    And I select "Deep Blue" from "field_s_icon_ext_columns[und][2][field_s_icon_ext_columns_bg_colo][und]"
    Then I press the "Save" button
    And I should see "Behat Icon Grid Block"
    And I should see 1 or more ".field-name-field-s-icon-ext-columns-fa-icon i" elements
    And I should see 1 or more ".field-name-field-s-icon-ext-columns-up-icon img" elements
    And I should see 1 or more ".field-name-field-s-icon-ext-columns-links a" elements
    And I should see "9090"
    And I should see 1 or more ".field-name-field-s-icon-ext-columns-text" elements
    Then I click "Delete Block"
    Then I press "Delete"
    Then I should see "Icon Grid Behat Icon Grid Block has been deleted."
