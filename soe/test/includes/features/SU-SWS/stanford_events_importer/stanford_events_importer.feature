Feature: Stanford Events Importer
  In order to ensure that upgrades do not break existing functionality
  As an administrative user
  I want to ensure that the Stanford Events Importer module is working properly

  @api @dev
  Scenario: Test the Events Importer content type fields
    Given I am logged in as a user with the "administrator" role
    And I am on "admin/structure/types/manage/stanford-event-importer/fields"
    Then I should see the heading "Stanford Event Importer"


  @api @dev
  Scenario: Test the Events content type fields
    Given I am logged in as a user with the "administrator" role
    And I am on "admin/structure/types/manage/stanford-event/fields"
    Then I should see the heading "Stanford Event"
    And I should see "body"
    And I should see "field_s_event_feed_type"
    And I should see "field_s_event_image_insert"
    And I should see "field_s_event_map_link"
    And I should see "field_s_event_type"
    And I should see "field_stanford_event_add_to_cal"
    And I should see "field_stanford_event_admission"
    And I should see "field_stanford_event_audience"
    And I should see "field_stanford_event_categories"
    And I should see "field_stanford_event_datetime"
    And I should see "field_stanford_event_email"
    And I should see "field_stanford_event_image"
    And I should see "field_stanford_event_location"
    And I should see "field_stanford_event_phone"
    And I should see "field_stanford_event_sponsor"
    And I should see "field_stanford_event_url"

  @api @dev
  Scenario: Create Stanford Event Content
    Given I am logged in as a user with the "administrator" role
    And I am on "node/add/stanford-event"
    Then I enter "Test Event" for "title"
    And I enter "Test Location" for "Location"
    And I enter "Test Admission" for "Admission"
    And I enter "Test Body" for "Body"
    And I enter "google.com" for "edit-field-s-event-map-link-und-0-url"
    And I enter "Test Sponsor" for "Event Sponsor"
    And I enter "Test@email.com" for "Contact Email"
    And I enter "111-111-1111" for "Contact Phone"
    And I enter "More Label" for "Title"
    And I enter "google.com" for "field_stanford_event_url[und][0][url]"
    And I press the "Save" button
    Then I should see the link "Map" in the "Content" region
    And I should see "Test Event" in the "Content" region
    And I should see "Test Location" in the "Content" region
    And I should see "Test Admission" in the "Content" region
    And I should see "Test Body" in the "Content" region
    And I should see "Test Sponsor" in the "Content" region
    And I should see "Test@email.com" in the "Content" region
    And I should see "111-111-1111" in the "Content" region
    And I should see the link "More Label" in the "Content" region


  @api @dev
  Scenario: Test the feeds importer
    Given I am logged in as a user with the "administrator" role
    And I am on "admin/structure/feeds/stanford_event_importer"
    Then I should see "Attached to: Stanford Event Importer"
    And I should see "Periodic import: as often as possible"
    And I should see "Import on submission"
    And I should see "HTTP Fetcher"
    And I should see "XPath XML parser"
    And I should see "Node processor"
    Then I am on "admin/structure/feeds/stanford_event_importer/settings/FeedsXPathParserXML"
    And the "xpath[context]" field should contain "//EventList/Event"
    And the "xpath[sources][xpathparser:0]" field should contain "title"
    And the "xpath[sources][xpathparser:1]" field should contain "guid"
    And the "xpath[sources][xpathparser:2]" field should contain "description"
    And the "xpath[sources][xpathparser:3]" field should contain "isoEventDate"
    And the "xpath[sources][xpathparser:4]" field should contain "status"
    And the "xpath[sources][xpathparser:5]" field should contain "Audience/audienceName"
    And the "xpath[sources][xpathparser:7]" field should contain "contactPhone"
    And the "xpath[sources][xpathparser:8]" field should contain "imageUrl"
    And the "xpath[sources][xpathparser:9]" field should contain "sponsor"
    And the "xpath[sources][xpathparser:10]" field should contain "url"
    And the "xpath[sources][xpathparser:11]" field should contain "locationText"
    And the "xpath[sources][xpathparser:12]" field should contain "admissionDescription"
    And the "xpath[sources][xpathparser:13]" field should contain "Category/categoryName"
    And the "xpath[sources][xpathparser:14]" field should contain "contactEmail"
    And the "xpath[sources][xpathparser:15]" field should contain "isoEventEndDate"
    And the "xpath[sources][xpathparser:16]" field should contain "concat('http://events.stanford.edu/ical/download.php?id=',eventID)"
    And the "xpath[sources][xpathparser:17]" field should contain "mapUrl"
    And the "xpath[sources][xpathparser:18]" field should contain "eventStatus"

  @api @dev
  Scenario: Test the archived feeds importer
    Given I am logged in as a user with the "administrator" role
    And I am on "admin/structure/feeds/stanford_event_archived_importer"
    Then I should see the heading "Stanford Event Archived Importer"
    And I should see "Attached to: [none]"
    And I should see "Periodic import: off"
    And I should see "Import on submission"
    And I should see "HTTP Fetcher"
    And I should see "XPath XML parser"
    And I should see "Node processor"
    Then I am on "admin/structure/feeds/stanford_event_archived_importer/settings/FeedsXPathParserXML"
    And the "xpath[context]" field should contain "//EventList/Event"
    And the "xpath[sources][xpathparser:0]" field should contain "title"
    And the "xpath[sources][xpathparser:1]" field should contain "eventID"
    And the "xpath[sources][xpathparser:2]" field should contain "description"
    And the "xpath[sources][xpathparser:3]" field should contain "isoBeginDate"
    And the "xpath[sources][xpathparser:4]" field should contain "eventStatus"
    And the "xpath[sources][xpathparser:5]" field should contain "Audience/audienceName"
    And the "xpath[sources][xpathparser:7]" field should contain "contactPhone"
    And the "xpath[sources][xpathparser:8]" field should contain "Media/imageUrl"
    And the "xpath[sources][xpathparser:9]" field should contain "sponsor"
    And the "xpath[sources][xpathparser:10]" field should contain "url"
    And the "xpath[sources][xpathparser:11]" field should contain "locationText"
    And the "xpath[sources][xpathparser:12]" field should contain "admissionDescription"
    And the "xpath[sources][xpathparser:13]" field should contain "Category/categoryName"
    And the "xpath[sources][xpathparser:14]" field should contain "contactEmail"
    And the "xpath[sources][xpathparser:15]" field should contain "isoEndDate"
    And the "xpath[sources][xpathparser:16]" field should contain "concat('http://events.stanford.edu/ical/download.php?id=',eventID)"
    And the "xpath[sources][xpathparser:17]" field should contain "mapUrl"
    And the "xpath[sources][xpathparser:18]" field should contain "eventStatus"
    And the "xpath[sources][xpathparser:19]" field should contain "People/person"


  @api @javascript @dev @destructive
  Scenario: Stanford Events Importer
    Given I am logged in as a user with the "administrator" role
    And I am on "node/add/stanford-event-importer"
    When I enter "[random]" for "Title"
    And I select the radio button "Organization"
    And I select "University Communications" from "edit-s-events-organization"
    And I select the radio button "Bookmarked"
    And I press the "Save" button
    And I wait for the batch job to finish
    Then I should see "Stanford Event Importer [random:1] has been created"
    When I am on "node/add/stanford-event-importer"
    And I enter "[random]" for "Title"
    And I select the radio button "Organization"
    And I select "Faculty Women's Forum" from "edit-s-events-organization"
    And I select the radio button "Unlisted"
    And I press the "Save" button
    And I wait for the batch job to finish
    Then I should see "Stanford Event Importer [random:1] has been created"
    When I am on "node/add/stanford-event-importer"
    And I enter "[random]" for "Title"
    And I select the radio button "Category"
    And I wait 1 second
    And I select "Film" from "edit-s-events-category"
    And I press the "Save" button
    And I wait for the batch job to finish
    Then I should see "Stanford Event Importer [random:1] has been created"
