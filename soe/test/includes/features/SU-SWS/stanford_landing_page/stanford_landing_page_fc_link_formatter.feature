Feature: Stanford Landing Page FC Link Formatter
  In order to ensure the field formatter is working
  As an administrative user
  I want view and edit a field display settings

  @api @safe
  Scenario: The display option for an image field is available.
    Given I am logged in as a user with the "administrator" role
    And I am on "admin/structure/field-collections/field_landing_page_item/display/large_landscape"
    Then I select "Image - Stanford Landing Page" from "fields[field_s_lp_item_image][type]"
    And I press the "Save" button
    And I press the "edit-fields-field-s-lp-item-image-settings-edit" button
    And I select "large-landscape" from "fields[field_s_lp_item_image][settings_edit_form][settings][image_style]"
    And I select "field-s-lp-item-link" from "fields[field_s_lp_item_image][settings_edit_form][settings][image_link]"
    And I press the "Save" button
    Then I should see "Image style: large-landscape"
    And I should see "field-s-lp-item-link"

  @api @safe
  Scenario: Create Landing Page and check FC Link Formatter
    Given I am logged in as a user with the "administrator" role
    And I am on "node/add/stanford-landing-page"
    Then I fill in "title" with "FC Link Formatter Test"
    And I select "Cards" from "field_s_landing_page_layout[und]"
    And I fill in "field_landing_page_item[und][0][field_s_lp_item_title][und][0][value]" with "Card #1"
    And I attach the file "features/stanford_landing_page/img/ooooaaaahhh.jpg" to "files[field_landing_page_item_und_0_field_s_lp_item_image_und_0]"
    Then I press the "Save" button
    And I should see "Primary link is required"
    Then I fill in "field_landing_page_item[und][0][field_s_lp_item_link][und][0][url]" with "http://google.com"
    And I press the "Save" button
    Then I should see a "img" element in the "Content" region
    And I click on the element with css selector ".field-name-field-s-lp-item-image a"
    Then I should see "Google"
    And I should be on "http://google.com"
