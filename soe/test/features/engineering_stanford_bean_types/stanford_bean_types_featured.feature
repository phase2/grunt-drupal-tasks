Feature: Stanford Bean Types Featured
  In order to ensure that upgrades do not break existing functionality
  As an end user
  I want to check that the Stanford Bean Types Featured module is working correctly

  @api @safe
  Scenario: Stanford Bean Types Featured Fields
    Given I am logged in as a user with the "administrator" role
    Then I am on "admin/structure/block-types/manage/stanford_featured_block/fields"
    And I should see "field_featured_block_featured"

    Then I am on "admin/structure/block-types/manage/stanford_featured_block/display"
    And I want to validate select field option "fields[group_featured_curtain][format][type]" default value is "div"
    And I want to validate select field option "fields[field_featured_block_featured][type]" default value is "paragraphs_view"

  @api @dev @destructive @javascript
  Scenario: Create Featured Block
    Given I am logged in as a user with the "administrator" role
    And I am on "block/add/stanford-featured-block"
    Then I fill in "label" with "Featured Block Test"
    Then I press the "Add Featured" Button
    And I wait for AJAX to finish

    Then I select the "Video W/ Image Overlay" radio button
    And I attach the file "features/engineering_stanford_bean_types/img/reefs.jpg" to "files[field_featured_block_featured_und_0_field_p_featured_image_und_0]"
    And I fill in "field_featured_block_featured[und][0][field_p_featured_video][und][0][video_url]" with "https://www.youtube.com/watch?v=QH8v0CkRlm8"
    And I fill in "field_featured_block_featured[und][0][field_p_featured_superhead][und][0][title]" with "Sample Superhead"
    And I fill in "field_featured_block_featured[und][0][field_p_featured_superhead][und][0][url]" with "https://www.stanford.edu"
    And I fill in "field_featured_block_featured[und][0][field_p_featured_headline][und][0][title]" with "Sample Headline"
    And I fill in "field_featured_block_featured[und][0][field_p_featured_headline][und][0][url]" with "https://www.stanford.edu"
    And I fill in "field_featured_block_featured[und][0][field_p_featured_description][und][0][value]" with "Sunt officiis reprehenderit eaque harum minus impedit quod reprehenderit. Ducimus aliquam iure fuga sint."

    Then I select the "Yes" radio button
    And I fill in "field_featured_block_featured[und][0][field_p_featured_more_link][und][0][title]" with "Sample Button"
    And I fill in "field_featured_block_featured[und][0][field_p_featured_more_link][und][0][url]" with "https://www.stanford.edu"
    Then I select the "Pink" radio button
    Then I press the "Save" button

    And I should be on "block/featured-block-test/view"
    And I should see 1 or more ".field-name-field-p-featured-image" elements
    And I should see 1 or more ".field-name-field-p-featured-image a.play-video" elements
    And I should see 1 or more ".group-overlay-text" elements
    And I should see 1 or more ".group-overlay-text .field-name-field-p-featured-superhead" elements
    And I should see 1 or more ".group-overlay-text .group-headline-h2" elements
    And I should see 1 or more ".group-overlay-text .field-name-field-p-featured-description" elements
    And I should see 1 or more ".group-overlay-text .field-name-field-p-featured-more-link" elements
    And I should see 1 or more ".group-overlay-text .field-name-field-p-featured-more-link a.btn-pink" elements

    Then I am on "block/featured-block-test/edit"
    And I press the "Delete" button
    Then I press the "Delete" button
    And I should see "stanford_featured_block Featured Block Test has been deleted."
