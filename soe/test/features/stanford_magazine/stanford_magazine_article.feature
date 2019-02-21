Feature: Stanford Magazine Article
  In order to ensure the fields for the Stanford Magazine Article module are correct.
  As an administrator

  @safe @api
  Scenario: Verify fields for the Stanford Magazine Article exist as expected
    Given I am logged in as a user with the "administrator" role
    Then I am on "admin/structure/types/manage/stanford_magazine_article/fields"
    And I should see "body"
    And I should see "field_s_mag_article_byline"
    And I should see "field_s_mag_article_date"
    And I should see "field_s_mag_article_dek"
    And I should see "field_s_mag_article_eyebrow"
    And I should see "field_s_mag_article_featured"
    And I should see "field_s_mag_article_headline"
    And I should see "field_s_mag_article_image"
    And I should see "field_s_mag_article_print"
    And I should see "field_s_mag_article_sections"
    And I should see "field_s_mag_article_series"
    And I should see "field_s_mag_article_topics"

    Then I am on "admin/structure/types/manage/stanford_magazine_article/display/default"
    And I want to validate select field option "fields[body][type]" default value is "text_default"
    And I want to validate select field option "fields[field_s_mag_article_byline][type]" default value is "text_default"
    And I want to validate select field option "fields[field_s_mag_article_date][type]" default value is "date_default"
    And I want to validate select field option "fields[field_s_mag_article_dek][type]" default value is "text_default"
    And I want to validate select field option "fields[field_s_mag_article_eyebrow][type]" default value is "hidden"
    And I want to validate select field option "fields[field_s_mag_article_featured][type]" default value is "list_default"
    And I want to validate select field option "fields[field_s_mag_article_headline][type]" default value is "hidden"
    And I want to validate select field option "fields[field_s_mag_article_image][type]" default value is "hidden"
    And I want to validate select field option "fields[field_s_mag_article_print][type]" default value is "link_default"
    And I want to validate select field option "fields[field_s_mag_article_sections][type]" default value is "paragraphs_view"
    And I want to validate select field option "fields[field_s_mag_article_series][type]" default value is "hidden"
    And I want to validate select field option "fields[field_s_mag_article_topics][type]" default value is "taxonomy_term_reference_link"

    Then I am on "admin/structure/types/manage/stanford_magazine_article/display/full"
    And I want to validate select field option "fields[body][type]" default value is "text_default"
    And I want to validate select field option "fields[field_s_mag_article_byline][type]" default value is "text_default"
    And I want to validate select field option "fields[field_s_mag_article_byline][parent]" default value is "group_s_date_and_byline"
    And I want to validate select field option "fields[field_s_mag_article_date][type]" default value is "date_default"
    And I want to validate select field option "fields[field_s_mag_article_date][parent]" default value is "group_s_date_and_byline"
    And I want to validate select field option "fields[field_s_mag_article_dek][type]" default value is "text_default"
    And I want to validate select field option "fields[field_s_mag_article_eyebrow][region]" default value is "hidden"
    And I want to validate select field option "fields[field_s_mag_article_featured][region]" default value is "hidden"
    And I want to validate select field option "fields[field_s_mag_article_headline][region]" default value is "hidden"
    And I want to validate select field option "fields[field_s_mag_article_image][region]" default value is "hidden"
    And I want to validate select field option "fields[field_s_mag_article_print][type]" default value is "link_default"
    And I want to validate select field option "fields[field_s_mag_article_print][parent]" default value is "group_s_social_and_print"
    And I want to validate select field option "fields[field_s_mag_article_sections][type]" default value is "paragraphs_view"
    And I want to validate select field option "fields[field_s_mag_article_series][region]" default value is "hidden"
    And I want to validate select field option "fields[field_s_mag_article_topics][type]" default value is "ds_taxonomy_separator"

    Then I am on "admin/structure/types/manage/stanford_magazine_article/display/taxonomy"
    And I want to validate select field option "fields[body][region]" default value is "hidden"
    And I want to validate select field option "fields[field_s_mag_article_byline][type]" default value is "text_default"
    And I want to validate select field option "fields[field_s_mag_article_date][type]" default value is "date_default"
    And I want to validate select field option "fields[field_s_mag_article_dek][type]" default value is "text_default"
    And I want to validate select field option "fields[field_s_mag_article_eyebrow][region]" default value is "hidden"
    And I want to validate select field option "fields[field_s_mag_article_featured][region]" default value is "hidden"
    And I want to validate select field option "fields[field_s_mag_article_headline][type]" default value is "text_default"
    And I want to validate select field option "fields[field_s_mag_article_image][type]" default value is "colorbox"
    And I want to validate select field option "fields[field_s_mag_article_print][region]" default value is "hidden"
    And I want to validate select field option "fields[field_s_mag_article_sections][region]" default value is "hidden"
    And I want to validate select field option "fields[field_s_mag_article_series][region]" default value is "hidden"
    And I want to validate select field option "fields[field_s_mag_article_topics][type]" default value is "taxonomy_term_reference_link"

    Then I am on "admin/structure/types/manage/stanford_magazine_article/display/teaser"
    And I want to validate select field option "fields[body][type]" default value is "hidden"
    And I want to validate select field option "fields[field_s_mag_article_byline][type]" default value is "hidden"
    And I want to validate select field option "fields[field_s_mag_article_date][type]" default value is "hidden"
    And I want to validate select field option "fields[field_s_mag_article_dek][type]" default value is "text_default"
    And I want to validate select field option "fields[field_s_mag_article_eyebrow][type]" default value is "hidden"
    And I want to validate select field option "fields[field_s_mag_article_featured][type]" default value is "hidden"
    And I want to validate select field option "fields[field_s_mag_article_headline][type]" default value is "hidden"
    And I want to validate select field option "fields[field_s_mag_article_image][type]" default value is "hidden"
    And I want to validate select field option "fields[field_s_mag_article_print][type]" default value is "hidden"
    And I want to validate select field option "fields[field_s_mag_article_sections][type]" default value is "hidden"
    And I want to validate select field option "fields[field_s_mag_article_series][type]" default value is "hidden"
    And I want to validate select field option "fields[field_s_mag_article_topics][type]" default value is "hidden"

  @safe
  Scenario: Verify the Stanford Magazine Article displays as expected
    Given I am on "magazine/article/jeremy-bailenson-taking-grand-tour-latest-virtual-reality"
    Then I should see a "h1" element in the "Content Body" region
    Then I should see 1 ".field-name-field-s-mag-article-dek" element
    Then I should see 1 or more ".field-name-field-s-mag-article-topics" elements
    Then I should see 1 ".field-name-field-s-mag-article-byline" element
    Then I should see 1 ".group-s-social-and-print" element
    Then I should see 1 ".caption" element
    Then I should see 1 ".paragraphs-items" element
    Then I should see 1 "#block-ds-extras-related-departments" element
    Then I should see 1 "#block-bean-stanford-soe-mag-news-signup" element
    Then I should see 1 ".view-stanford-magazine-article-collection" element

  @safe
  Scenario: Verify order of articles displays in descending order on a Stanford Magazine Article
    Given I am on "magazine/article/jeremy-bailenson-taking-grand-tour-latest-virtual-reality"
    Then I should see all timestamps for ".mag-article-date" in "descending" order



