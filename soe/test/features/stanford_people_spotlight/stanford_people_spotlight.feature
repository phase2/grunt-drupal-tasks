Feature: Stanford People Spotlight
  In order to ensure the fields for the Stanford People Spotlight module are correct.
  As an administrator

  @safe @api
  Scenario: Verify Stanford People Spotlight fields exist as expected
    Given I am logged in as a user with the "administrator" role
    Then I am on "admin/structure/types/manage/stanford_people_spotlight/fields"
    And I should see "body"
    And I should see "field_s_ppl_spot_affiliation"
    And I should see "field_s_ppl_spot_date"
    And I should see "field_s_ppl_spot_degrees"
    And I should see "field_s_ppl_spot_department"
    And I should see "field_s_ppl_spot_image"
    And I should see "field_s_ppl_spot_image_color"
    And I should see "field_s_ppl_spot_name_color"
    And I should see "field_s_ppl_spot_photo_credit"
    And I should see "field_s_ppl_spot_quote"
    And I should see "field_s_ppl_spot_related_page"
    And I should see "field_s_ppl_spot_title"

    Then I am on "admin/structure/types/manage/stanford_people_spotlight/display/default"
    And I want to validate select field option "fields[body][type]" default value is "text_default"
    And I want to validate select field option "fields[field_s_ppl_spot_affiliation][type]" default value is "taxonomy_term_reference_link"
    And I want to validate select field option "fields[field_s_ppl_spot_date][type]" default value is "date_default"
    And I want to validate select field option "fields[field_s_ppl_spot_degrees][type]" default value is "text_default"
    And I want to validate select field option "fields[field_s_ppl_spot_department][type]" default value is "taxonomy_term_reference_link"
    And I want to validate select field option "fields[field_s_ppl_spot_image][type]" default value is "image"
    And I want to validate select field option "fields[field_s_ppl_spot_image_color][type]" default value is "taxonomy_term_reference_link"
    And I want to validate select field option "fields[field_s_ppl_spot_name_color][type]" default value is "taxonomy_term_reference_link"
    And I want to validate select field option "fields[field_s_ppl_spot_photo_credit][type]" default value is "text_default"
    And I want to validate select field option "fields[field_s_ppl_spot_quote][type]" default value is "text_default"
    And I want to validate select field option "fields[field_s_ppl_spot_related_page][type]" default value is "entityreference_label"
    And I want to validate select field option "fields[field_s_ppl_spot_title][type]" default value is "text_default"

    Then I am on "admin/structure/types/manage/stanford_people_spotlight/display/full"
    And I want to validate select field option "fields[body][type]" default value is "text_default"
    And I want to validate select field option "fields[body][parent]" default value is "group_s_ppl_spot_content_cntnr"
    And I want to validate select field option "fields[field_s_ppl_spot_affiliation][region]" default value is "hidden"
    And I want to validate select field option "fields[field_s_ppl_spot_date][type]" default value is "date_default"
    And I want to validate select field option "fields[field_s_ppl_spot_date][parent]" default value is "group_s_ppl_spot_date_container"
    And I want to validate select field option "fields[field_s_ppl_spot_degrees][region]" default value is "hidden"
    And I want to validate select field option "fields[field_s_ppl_spot_department][region]" default value is "hidden"
    And I want to validate select field option "fields[field_s_ppl_spot_image][region]" default value is "hidden"
    And I want to validate select field option "fields[field_s_ppl_spot_image_color][region]" default value is "hidden"
    And I want to validate select field option "fields[field_s_ppl_spot_name_color][region]" default value is "hidden"
    And I want to validate select field option "fields[field_s_ppl_spot_photo_credit][type]" default value is "text_plain"
    And I want to validate select field option "fields[field_s_ppl_spot_photo_credit][parent]" default value is "group_s_ppl_spot_content_cntnr"
    And I want to validate select field option "fields[field_s_ppl_spot_quote][type]" default value is "text_default"
    And I want to validate select field option "fields[field_s_ppl_spot_quote][parent]" default value is "group_s_ppl_spot_summary"
    And I want to validate select field option "fields[field_s_ppl_spot_related_page][region]" default value is "hidden"
    And I want to validate select field option "fields[field_s_ppl_spot_title][region]" default value is "hidden"

    Then I am on "admin/structure/types/manage/stanford_people_spotlight/display/teaser"
    And I want to validate select field option "fields[body][type]" default value is "text_summary_or_trimmed"
    And I want to validate select field option "fields[field_s_ppl_spot_affiliation][type]" default value is "hidden"
    And I want to validate select field option "fields[field_s_ppl_spot_date][type]" default value is "hidden"
    And I want to validate select field option "fields[field_s_ppl_spot_degrees][type]" default value is "hidden"
    And I want to validate select field option "fields[field_s_ppl_spot_department][type]" default value is "hidden"
    And I want to validate select field option "fields[field_s_ppl_spot_image][type]" default value is "hidden"
    And I want to validate select field option "fields[field_s_ppl_spot_image_color][type]" default value is "hidden"
    And I want to validate select field option "fields[field_s_ppl_spot_name_color][type]" default value is "hidden"
    And I want to validate select field option "fields[field_s_ppl_spot_photo_credit][type]" default value is "hidden"
    And I want to validate select field option "fields[field_s_ppl_spot_quote][type]" default value is "hidden"
    And I want to validate select field option "fields[field_s_ppl_spot_related_page][type]" default value is "hidden"
    And I want to validate select field option "fields[field_s_ppl_spot_title][type]" default value is "hidden"


  @safe @api
  Scenario: Verify Stanford People Spotlight fields display as expected
    Given I am on "spotlight"
    Then I should not see an ".edit-link" element
    Then I should see a ".view-stanford-ppl-spot-3-v-card" element
    Then I should see a ".view-stanford-ppl-spot-3-v-card .spotlight-container.well" element

