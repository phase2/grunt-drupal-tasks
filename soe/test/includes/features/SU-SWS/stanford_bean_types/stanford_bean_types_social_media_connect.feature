@api
Feature: Stanford social_media_connect bean Type
  In order to ensure that the social_media_connect bean exists
  As an administrator
  I want to check that the Stanford social_media_connect bean types module is working correctly

  Background:
    Given I am logged in as a user with the "administrator" role

  @safe
  Scenario: Stanford social_media_connect type exists
    And I am on "block/add"
    Then I should see the link "stanford_social_media_connect" in the "Content" region

  @safe
  Scenario: Stanford Social Block Type Fields Exist
    Given I am on "admin/structure/block-types/manage/stanford-social-media-connect/fields"
    Then I should see "Label"
    And I should see "Title"
    And I should see "field_s_smc_links"
    And I should not see "field_s_smc_facebook"
    And I should not see "field_s_smc_twitter"
    And I should not see "field_s_smc_googleplus"
    And I should not see "field_s_smc_linkedin"
    And I should not see "field_s_smc_instagram"
    And I should not see "field_s_smc_youtube"
    And I should not see "field_s_smc_vimeo"
    And I should not see "field_s_smc_tumblr"
    And I should not see "field_s_smc_pinterest"
    And I should not see "field_s_smc_flickr"
    And I should see "view_mode"
    Then I am on "admin/structure/field-collections/field_s_smc_links"
    And I should see "field_s_smc_color"
    And I should see "field_s_smc_icon"
    And I should see "field_s_smc_link"

  @safe
  Scenario: Stanford Social Block Type Display Modes
    Given I am on "admin/structure/block-types/manage/stanford-social-media-connect/display"
    Then I should not see "Facebook"
    Then I should not see "Twitter"
    Then I should not see "GooglePlus"
    Then I should not see "LinkedIn"
    Then I should not see "Instagram"
    Then I should not see "YouTube"
    Then I should not see "Vimeo"
    Then I should not see "Tumblr"
    Then I should not see "Pinterest"
    Then I should not see "Flickr"

  @dev @destructive
  Scenario: Create stanford social media connect block
    And I am on "block/add/stanford-social-media-connect"
    Then I fill in "edit-label" with "Behat Social Block"
    And I fill in "edit-title" with "Behat Social Block"
    And I select "Facebook Blue" from "field_s_smc_links[und][0][field_s_smc_color][und]"
    And I select "Facebook" from "field_s_smc_links[und][0][field_s_smc_icon][und][0][icon]"
    And I fill in "field_s_smc_links[und][0][field_s_smc_link][und][0][title]" with "Facebook"
    And I fill in "field_s_smc_links[und][0][field_s_smc_link][und][0][url]" with "facebook.com"
    Then I press "Add another item"
    And I select "Youtube Red" from "field_s_smc_links[und][1][field_s_smc_color][und]"
    And I select "YouTube" from "field_s_smc_links[und][1][field_s_smc_icon][und][0][icon]"
    And I fill in "field_s_smc_links[und][1][field_s_smc_link][und][0][title]" with "Youtube"
    And I fill in "field_s_smc_links[und][1][field_s_smc_link][und][0][url]" with "youtube.com"
    Then I press "Save"
    Then I should see "stanford_social_media_connect Behat Social Block has been created."
    Then I should see "Behat Social Block"
    Then I should see 1 or more ".field-name-field-s-smc-links i" elements
    Then I click "Delete Block"
    Then I press "Delete"
    Then I should see "stanford_social_media_connect Behat Social Block has been deleted."
