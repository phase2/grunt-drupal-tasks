  @api
  Feature: Stanford News
    In order to verify news items
    As an end user
    I want to check for the existence of news content

  Background:
    Given I am logged in as a user with the "administrator" role

  @safe
  Scenario: News Item Content type is available
    Given I am on "admin/structure/types"
    Then I should see "News Item"
    Then I should see "stanford_news_item"

  @safe
  Scenario: Fields are available on the content type
    Given I am on "admin/structure/types/manage/stanford-news-item/fields"
    Then I should see "group_s_news_external_info"
    Then I should see "field_s_news_date"
    Then I should see "field_s_news_source"
    Then I should see "field_s_news_categories"
    Then I should see "field_s_image_info"
    Then I should see "body"
    Then I should see "field_s_news_link"
    Then I should see "field_s_news_image_insert"
    Then I should see "field_s_news_attachment"
    Then I should see "group_s_news_advanced"
    Then I should see "field_s_news_featured"

  @safe
  Scenario: The display modes are available
    Given I am on "admin/structure/types/manage/stanford-news-item/display"
    Then the "edit-additional-settings-modes-view-modes-custom-full" checkbox should be checked
    Then the "edit-additional-settings-modes-view-modes-custom-teaser" checkbox should be checked

  @safe
  Scenario: The full content display mode
    # Full content display
    Given I am on "admin/structure/types/manage/stanford-news-item/display/full"
    Then I should see "postcard-image group_s_postcard_image"
    Then I should see "postcard-postedin group_s_news_postedin"
    Then I want to validate select field option "edit-fields-field-s-image-info-type" default is "Field collection items"
    Then I want to validate select field option "edit-fields-field-s-news-date-type" default is "Date and time"
    Then I want to validate select field option "edit-fields-field-s-news-link-type" default is "Title, as link (default)"

@safe
    Scenario: The teaser display mode
        # teaser display
    Given I am on "admin/structure/types/manage/stanford-news-item/display/teaser"
    Then I should see "Trimmed limit: 600 characters"
    Then I want to validate select field option "edit-fields-body-type" default is "Summary or trimmed"

  @safe
  Scenario: The news categories vocabulary is available
    Given I am on "admin/structure/taxonomy"
    Then I should see "News Categories"
    Then I am on "admin/structure/taxonomy/news_categories"

  @dev @destructive
  Scenario: Create news item and validate display
    Given I am on "node/add/stanford-news-item"
    Then I fill in "edit-title" with "Behat Stanford News Item"
    Then I fill in "edit-field-s-news-source-und-0-title" with "This is the external source title"
    Then I fill in "edit-field-s-news-source-und-0-url" with "http://www.google.com"
    Then I attach the file "img/ooooaaaahhh.jpg" to "files[field_s_image_info_und_0_field_s_image_image_und_0]"
    Then I fill in "edit-field-s-image-info-und-0-field-s-image-credits-und-0-value" with "This is the image credits field"
    Then I fill in "edit-field-s-image-info-und-0-field-s-image-source-info-und-0-value" with "This is the image source field"
    Then I fill in "field_s_image_info[und][0][field_s_image_caption][und][0][value]" with "This is the image caption field"
    Then I fill in "body[und][0][value]" with "This is the body field"
    Then I fill in "edit-field-s-news-link-und-0-title" with "This is the external link title field"
    Then I fill in "edit-field-s-news-link-und-0-url" with "http://www.stanford.edu"
    Then I attach the file "img/ooooaaaahhh.jpg" to "edit-field-s-news-image-insert-und-0-upload"
    Then I check the box "edit-field-s-news-featured-und"
    Then I uncheck the box "path[pathauto]"
    Then I fill in "edit-path-alias" with "[random]"
    Then I press the "Save" button
    Then I should see "Behat Stanford News Item has been created"
    # Display
    #Then I should see 1 ".field-name-field-s-news-date" element
    #Then I should see 1 ".field-name-field-s-news-source" element
    Then I should see 1 ".field-name-body" element
    Then I should see 1 ".field-collection-item-field-s-image-info" element
    Then I should see "This is the image credits field"
    Then I should see "This is the image caption field"
    Then I should see "This is the body field"
    Then I should see "This is the external link title field"
    Then I click "This is the external link title field"
    Then I should be on "http://www.google.com"
