Feature: Stanford Bean Types Hero
  In order to ensure that upgrades do not break existing functionality
  As an end user
  I want to check that the Stanford Bean Types Hero module is working correctly

  @api @safe
  Scenario: Stanford Bean Types Hero Fields
    Given I am logged in as a user with the "administrator" role
    Then I am on "admin/structure/block-types/manage/stanford_hero_block/fields"
    And I should see "field_hero_block_hero"
    And I should see "field_hero_block_style"

    Then I am on "admin/structure/block-types/manage/stanford_hero_block/display/default"
    And I want to validate select field option "fields[field_hero_block_hero][type]" default value is "paragraphs_view"
    And I want to validate select field option "fields[field_hero_block_hero][parent]" default value is "group_hero_curtain"
    And I want to validate select field option "fields[field_hero_block_style][type]" default value is "hidden"

    Then I am on "admin/structure/block-types/manage/stanford_hero_block/display/large_landscape"
    And I want to validate select field option "fields[field_hero_block_hero][type]" default value is "paragraphs_view"
    And I want to validate select field option "fields[field_hero_block_hero][parent]" default value is "group_hero_scroll"
    And I want to validate select field option "fields[field_hero_block_style][type]" default value is "hidden"

    Then I am on "admin/structure/block-types/manage/stanford_hero_block/display/stanford_12_col_banner_tall"
    And I want to validate select field option "fields[field_hero_block_hero][type]" default value is "paragraphs_view"
    And I want to validate select field option "fields[field_hero_block_hero][parent]" default value is "group_hero_static"
    And I want to validate select field option "fields[field_hero_block_style][type]" default value is "hidden"

  @api @destructive @javascript
  Scenario: Create Hero Block
    Given I am logged in as a user with the "administrator" role
    And I am on "block/add/stanford-hero-block"
    Then I fill in "label" with "Hero Block Test"
    And I select "Curtain Reveal" from "Style"
    Then I press the "Add Hero" Button
    And I wait for AJAX to finish
    Then I select the "Video W/ Image Overlay" radio button
    And I attach the file "features/stanford_bean_types/img/ooooaaaahhh.jpg" to "files[field_hero_block_hero_und_0_field_p_hero_image_und_0]"
    And I fill in "field_hero_block_hero[und][0][field_p_hero_video][und][0][video_url]" with "https://www.youtube.com/watch?v=QH8v0CkRlm8"
    Then I press the "Save" button
    And I should be on "block/hero-block-test/view"
    And I should see 1 or more "body > .hero-curtain" elements

    Then I am on "block/hero-block-test/edit"
    And I select "Scroll Button" from "Style"
    And I press the "Save" button
    Then I should see 1 or more "body > .hero-scroll" elements
    Then I should see 1 or more ".hero-scroll a.scroll-down" elements

    Then I am on "block/hero-block-test/edit"
    And I select "Standard Header (No movement)" from "Style"
    And I press the "Save" button
    Then I should see 1 or more "body > .hero-static" elements

    Then I am on "block/hero-block-test/edit"
    And I press the "Delete" button
    Then I press the "Delete" button
    And I should see "stanford_hero_block Hero Block Test has been deleted."
