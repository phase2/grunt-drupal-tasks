Feature: Stanford Course Node Display
  In order to ensure that stanford courses was installed succesfully.
  As an administrative user
  I want to ensure that the Stanford Courses Node Display module is working properly

  @api @safe
  Scenario: Stanford Course Node Display
    Given I am logged in as a user with the "administrator" role
    Then I am on "admin/structure/types/manage/stanford_course/fields"
    And I should see "field_s_image_info"

    Then I am on "admin/structure/types/manage/stanford_course/display/default"
    And I want to validate select field option "fields[field_s_image_info][type]" default value is "field_collection_view"
    And I should see "group_coursenum_group"
    And I should see "group_morelink_group"
    And I should see "group_s_postcard_content"
    And I should see "group_s_postcard_image"
    And I want to validate select field option "fields[field_s_image_info][parent]" default value is "group_s_postcard_image"
    And I should see "group_s_postcard"

    Then I am on "admin/structure/types/manage/stanford_course/display/teaser"
    And I want to validate select field option "fields[field_s_image_info][type]" default value is "hidden"
