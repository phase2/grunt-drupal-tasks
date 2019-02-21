## This feature checks for the content that is deployed on a bunch of our
## products. This content is not bundled in the module and should be kept in its
## own test because of that.

Feature: Stanford Private Page Fields
In order to ensure that the expected Stanford Private Page Fields exist
As all types of users
I want to check for that the fields exist

@safe @api
Scenario: Verify manage Private Page Fields exist
Given I am logged in as a user with the "administrator" role
Then I am on "admin/structure/types/manage/stanford_private_page/fields"
And I should see "body"
And I should see "field_s_image_info"
And I should see "field_s_private_file"
And I should see "field_s_private_image_insert"

Then I am on "admin/structure/types/manage/stanford_private_page/display/default"
And I want to validate select field option "fields[body][type]" default value is "text_default"
And I want to validate select field option "fields[body][parent]" default value is "group_s_postcard_content"
And I want to validate select field option "fields[field_s_image_info][type]" default value is "field_collection_view"
And I want to validate select field option "fields[field_s_image_info][parent]" default value is "group_s_postcard_image"
And I want to validate select field option "fields[field_s_private_file][type]" default value is "file_default"
And I want to validate select field option "fields[field_s_private_file][parent]" default value is "group_s_postcard_content"
And I want to validate select field option "fields[field_s_private_image_insert][type]" default value is "hidden"

Then I am on "admin/structure/types/manage/stanford_private_page/display/teaser"
And I want to validate select field option "fields[body][type]" default value is "text_summary_or_trimmed"
And I want to validate select field option "fields[field_s_image_info][type]" default value is "hidden"
And I want to validate select field option "fields[field_s_private_file][type]" default value is "hidden"
And I want to validate select field option "fields[field_s_private_image_insert][type]" default value is "hidden"
Then I am on "admin/structure/types/manage/stanford_private_page/fields"
And I should see "body"
And I should see "field_s_image_info"
And I should see "field_s_private_file"
And I should see "field_s_private_image_insert"

Then I am on "admin/structure/types/manage/stanford_private_page/display/default"
And I want to validate select field option "fields[body][type]" default value is "text_default"
And I want to validate select field option "fields[body][parent]" default value is "group_s_postcard_content"
And I want to validate select field option "fields[field_s_image_info][type]" default value is "field_collection_view"
And I want to validate select field option "fields[field_s_image_info][parent]" default value is "group_s_postcard_image"
And I want to validate select field option "fields[field_s_private_file][type]" default value is "file_default"
And I want to validate select field option "fields[field_s_private_file][parent]" default value is "group_s_postcard_content"
And I want to validate select field option "fields[field_s_private_image_insert][type]" default value is "hidden"

Then I am on "admin/structure/types/manage/stanford_private_page/display/teaser"
And I want to validate select field option "fields[body][type]" default value is "text_summary_or_trimmed"
And I want to validate select field option "fields[field_s_image_info][type]" default value is "hidden"
And I want to validate select field option "fields[field_s_private_file][type]" default value is "hidden"
And I want to validate select field option "fields[field_s_private_image_insert][type]" default value is "hidden"
