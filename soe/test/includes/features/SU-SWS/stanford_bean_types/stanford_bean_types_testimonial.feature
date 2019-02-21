@api
Feature: Stanford testimonial bean Type
  In order to ensure that the testimonial bean exists
  As an administrator
  I want to check that the Stanford testimonial bean types module is working correctly

  Background:
    Given I am logged in as a user with the "administrator" role

  @safe
  Scenario: Stanford testimonial type exists
    And I am on "block/add"
    Then I should see the link "stanford_testimonial_block" in the "Content" region

  @safe
  Scenario: Stanford Testimonial Block Type Fields Exist
    Given I am on "admin/structure/block-types/manage/stanford-testimonial-block/fields"
    Then I should see "Label"
    Then I should see "Title"
    Then I should see "field_s_image_info"
    Then I should see "field_s_testimonial_quote"
    Then I should see "field_s_testimonial_credits"
    Then I should see "field_testimonial_more_link"
    Then I should see "view_mode"

  @safe
  Scenario: Stanford Testimonial Block Type Display
    Given I am on "admin/structure/block-types/manage/stanford-testimonial-block/display"
    Then I should see "View mode: Medium Square"
    Then I should see "Postcard"
    Then I should see "group_postcard"
    Then I should see "first group"
    Then I should see "group_first_group"
    Then I should see "Circle Image"
    Then I should see "group_s_circle_image_style"
    Then I should see "Image"
    Then I should see "second group"
    Then I should see "group_second_group"
    Then I should see "Quote"
    Then I should see "group_s_quote_style"
    Then I should see "Quote"
    Then I should see "Credits"
    Then I should see "group_s_credits_style"
    Then I should see "More Link"
    Then I should see "group_s_more_link_style"
    Then I should see "postcard-right"
    Then I should see "group-s-circle-image-style field-group-div"
    Then I should see "group-s-quote-style field-group-div quote"
    Then I should see "group-s-credits-style field-group-div credits"
    Then I should see "group-s-more-link-style field-group-div more-link"
    Then I should see "No field is hidden."

  @dev @destructive
  Scenario: Create stanford banner block
    And I am on "block/add/stanford-testimonial-block"
    Then I fill in "edit-label" with "Behat Testimonial Block"
    Then I fill in "edit-title" with "Behat Testimonial Block"
    Then I attach the file "features/stanford_bean_types/img/ooooaaaahhh.jpg" to "files[field_s_image_info_und_0_field_s_image_image_und_0]"
    Then I fill in "field_s_image_info[und][0][field_s_image_credits][und][0][value]" with "This is the credits"
    Then I fill in "field_s_image_info[und][0][field_s_image_source_info][und][0][value]" with "This is the source"
    Then I fill in "field_s_image_info[und][0][field_s_image_caption][und][0][value]" with "This is the caption"
    Then I fill in "field_s_testimonial_quote[und][0][value]" with "This is the quote"
    Then I fill in "field_s_testimonial_credits[und][0][value]" with "This is the credits"
    Then I fill in "field_testimonial_more_link[und][0][title]" with "This is the read more link title"
    Then I fill in "field_testimonial_more_link[und][0][url]" with "http://www.stanford.edu"
    Then I press "Save"
    Then I should see "stanford_testimonial_block Behat Testimonial Block has been created."
    Then I should see "Behat Testimonial Block"
    Then I should see "This is the quote"
    Then I should see "This is the credits"
    Then I should see "This is the read more link title"
    Then I should see 1 ".field-collection-item-field-s-image-info img" element
    Then I click "Delete Block"
    Then I press "Delete"
    Then I should see "stanford_testimonial_block Behat Testimonial Block has been deleted."
