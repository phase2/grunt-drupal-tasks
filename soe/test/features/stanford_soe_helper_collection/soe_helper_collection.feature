Feature: Stanford SoE Helper Collection
In order to verify the Stanford SoE Helper Collection fields and display
defaults.
As an administrator
I want to be able to view the modules for magazines as enabled

@api @safe
Scenario: Verify Collection fields
Given I am logged in as a user with the "administrator" role

Then I am on "admin/structure/types/manage/stanford_collection/fields"
And I should see "field_s_col_article_accent_color"
And I should see "field_s_collection_cont_label"
And I should see "field_s_collection_lead_text"
And I should see "field_s_collection_subtitle"
And I should see "field_s_collectlon_intro_label"

Then I am on "admin/structure/types/manage/stanford_collection/display/default"
And I want to validate select field option "fields[field_s_col_article_accent_color][type]" default value is "hidden"
And I want to validate select field option "fields[field_s_collection_cont_label][type]" default value is "hidden"
And I want to validate select field option "fields[field_s_collection_lead_text][type]" default value is "text_plain"
And I want to validate select field option "fields[field_s_collection_subtitle][type]" default value is "text_plain"
And I want to validate select field option "fields[field_s_collectlon_intro_label][type]" default value is "hidden"

Then I am on "admin/structure/types/manage/stanford_collection/display/teaser"
And I want to validate select field option "fields[field_s_col_article_accent_color][type]" default value is "hidden"
And I want to validate select field option "fields[field_s_collection_cont_label][type]" default value is "hidden"
And I want to validate select field option "fields[field_s_collection_lead_text][type]" default value is "text_default"
And I want to validate select field option "fields[field_s_collection_subtitle][type]" default value is "text_default"
And I want to validate select field option "fields[field_s_collectlon_intro_label][type]" default value is "hidden"

Then I am on "admin/structure/types/manage/stanford_magazine_article/fields"
And I should see "field_s_mag_article_collection"

Then I am on "admin/structure/types/manage/stanford_magazine_article/display/default"
And I want to validate select field option "fields[field_s_mag_article_collection][type]" default value is "entityreference_label"

Then I am on "admin/structure/types/manage/stanford_magazine_article/display/full"
And I want to validate select field option "fields[field_s_mag_article_collection][type]" default value is "entityreference_label"

Then I am on "admin/structure/types/manage/stanford_magazine_article/display/taxonomy"
And I want to validate select field option "fields[field_s_mag_article_collection][region]" default value is "hidden"

Then I am on "admin/structure/types/manage/stanford_magazine_article/display/teaser"
And I want to validate select field option "fields[field_s_mag_article_collection][type]" default value is "hidden"
