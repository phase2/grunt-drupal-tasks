@dev
Feature: Stanford Conference
  In order to ensure that the stanford_conference module is installed and functional
  As an administrative user
  I want to ensure that the Stanford Conference module is working properly

  Background:
    Given I am logged in as a user with the "administrator" role

  @api @safe
  Scenario: Check that the content types exist
    And I am on "admin/structure/types"
    Then I should see "Conference Overview"
    And I should see "Conference Session"

  @api @safe
  Scenario: Check that the session fields are available
    And I am on "admin/structure/types/manage/stanford-conference-session/fields"
    Then I should see "title"
    And I should see "field_s_session_conference"
    And I should see "field_s_session_date_time"
    And I should see "field_s_session_speaker"

  @api @safe
  Scenario: Check that the overview fields are available
    And I am on "admin/structure/types/manage/stanford-conference-overview/fields"
    Then I should see "title"
    And I should see "body"
    And I should see "field_s_conference_lead_text"
    And I should see "field_s_conference_reg_link"
    And I should see "field_s_conference_date"
    And I should see "field_s_conference_location"
    And I should see "field_s_conference_map_link"
    And I should see "field_s_conference_file_insert"
    And I should see "field_s_conference_phone"
    And I should see "field_s_conference_email"
    And I should see "field_s_conference_contact_url"
    And I should see "field_s_conference_sponsors"
    And I should see "group_s_conference_contact"

  @api @deploy
  Scenario: Check that the custom displays are available for conference overview
    And I am on "admin/structure/types/manage/stanford-conference-overview/display"
    And the "edit-additional-settings-modes-view-modes-custom-full" checkbox should be checked
    And the "edit-additional-settings-modes-view-modes-custom-teaser" checkbox should be checked

  @api @deploy
  Scenario: Check that the custom displays are available for conference session
    And I am on "admin/structure/types/manage/stanford-conference-session/display"
    And the "edit-additional-settings-modes-view-modes-custom-teaser" checkbox should be checked

  @api @deploy
  Scenario: Check the custom display mode of the conference session teaser
    And I am on "admin/structure/types/manage/stanford-conference-session/display/teaser"
    Then I should see "No field is displayed"

  @api @deploy
  Scenario: Check the custom display mode of the conference overview full content
    And I am on "admin/structure/types/manage/stanford-conference-overview/display/full"
    Then I should see "group_conf_lead_text_styles"
    Then I should see "Lead Text"
    Then I should see "Registration Link"
    Then I should see "group_conf_overview"
    Then I should see "group_conf_descriptor"
    Then I should see "Date and Time"
    Then I should see "Location"
    Then I should see "Map Link"
    Then I should see "Body"
    Then I should see "Documents"
    Then I want to validate select field option "edit-fields-group-conf-lead-text-styles-region" default is "Content"
    Then I want to validate select field option "edit-fields-field-s-conference-lead-text-region" default is "Content"
    Then I want to validate select field option "edit-fields-field-s-conference-reg-link-region" default is "Content"
    Then I want to validate select field option "edit-fields-group-conf-overview-region" default is "Content"
    Then I want to validate select field option "edit-fields-group-conf-descriptor-region" default is "Content"
    Then I want to validate select field option "edit-fields-field-s-conference-date-region" default is "Content"
    Then I want to validate select field option "edit-fields-field-s-conference-location-region" default is "Content"
    Then I want to validate select field option "edit-fields-field-s-conference-map-link-region" default is "Content"
    Then I want to validate select field option "edit-fields-body-region" default is "Content"
    Then I want to validate select field option "edit-fields-field-s-conference-file-insert-region" default is "Content"

  # @api @safe @deploy
  # Scenario: Check the custom display mode of the conference overview teaser
  #   And I am on "admin/structure/types/manage/stanford-conference-overview/display/teaser"
  #   Then I should see "Body"
  #   Then I want to validate select field option "edit-fields-body-region" default is "Content" // Does not exist...

  @api @deploy @javascript
  Scenario: Check the context conference_agenda is available and correct.
    And I am on "admin/structure/context/list/conference_agenda/edit"
    Then I click on the element with css selector ".context-plugin-views.active a"
    Then the "edit-conditions-plugins-views-values-conference-session-agendapage" checkbox should be checked
    Then I click on the element with css selector ".context-plugin-block.active a"
    Then I should see "View: Conference: Link to Overview"

  @api @deploy @javascript
  Scenario: Check the context conference_overview is available and correct.
    And I am on "admin/structure/context/list/conference_overview/edit"
    Then I click on the element with css selector ".context-plugin-node.active a"
    Then the "edit-conditions-plugins-node-values-stanford-conference-overview" checkbox should be checked
    Then I click on the element with css selector ".context-plugin-block.active a"
    Then I should see "View: Conference: Link to Agenda"
    Then I should see "View: Conference: Image"
    Then I should see "View: Conference: Contact Info"
    Then I should see "View: Conference: Sponsors"

  @api @deploy
  Scenario: Check the conference views are all there.
    And I am on "admin/structure/views"
    Then I go to "admin/structure/views/view/conference_session_agenda/edit"
    Then I go to "admin/structure/views/view/conference_contact_info/edit"
    Then I go to "admin/structure/views/view/conference_image/edit"
    Then I go to "admin/structure/views/view/s_conference_link_to_agenda/edit"
    Then I go to "admin/structure/views/view/conference_link_to_overview/edit"
    Then I go to "admin/structure/views/view/conference_sponsors/edit"
    Then I go to "admin/structure/views/view/conferences/edit"

  @api @dev @destructive
  Scenario: Check that conference content can be created and displays correctly.
    And I am on "node/add/stanford-conference-overview"

    Then I fill in "edit-title" with "Conference Overview Behat"
    Then I fill in "Lead Text" with "This is lead text"
    Then I fill in "field_s_conference_reg_link[und][0][title]" with "My Reg Link Title"
    Then I fill in "field_s_conference_reg_link[und][0][url]" with "http://www.google.com"
    Then I fill in "field_s_conference_date[und][0][value][date]" with "03/31/2019"
    Then I fill in "field_s_conference_date[und][0][value][time]" with "08:00am"
    Then I fill in "field_s_conference_date[und][0][value2][date]" with "04/14/2019"
    Then I fill in "field_s_conference_date[und][0][value2][time]" with "06:00pm"
    Then I fill in "Location" with "Stanford Web Services - Laurel"
    Then I fill in "field_s_conference_map_link[und][0][url]" with "https://maps.google.com"
    # Then I fill in "Hello, my name is Nick" in WYSIWYG editor "cke_contents_edit-body-und-0-value-iframe"
    Then I attach the file "img/ooooaaaahhh.jpg" to "edit-field-s-conference-image-und-0-upload"
    Then I fill in "field_s_conference_phone[und][0][value]" with "650-725-1234"
    Then I fill in "field_s_conference_email[und][0][value]" with "email-address@stanford.edu"
    Then I fill in "field_s_conference_contact_url[und][0][title]" with "John G. Gerhind"
    Then I fill in "field_s_conference_contact_url[und][0][url]" with "http://www.google.com"
    Then I fill in "field_s_conference_sponsors[und][0][field_s_sponsor_name][und][0][title]" with "Sponsor Title"
    Then I fill in "field_s_conference_sponsors[und][0][field_s_sponsor_name][und][0][url]" with "https://www.stanford.edu"
    Then I attach the file "img/ooooaaaahhh.jpg" to "edit-field-s-conference-sponsors-und-0-field-s-sponsor-image-und-0-upload"
    And I press the "Save" button
    Then I should see "Conference Overview Conference Overview BeHat has been created"

    Then I go to "node/add/stanford-conference-session"
    Then I fill in "edit-title" with "Behat Session One"
    And I select "Conference Overview Behat" from "edit-field-s-session-conference-und"
    Then I fill in "field_s_session_date_time[und][0][value][date]" with "03/31/2019"
    Then I fill in "field_s_session_date_time[und][0][value][time]" with "01:00pm"
    Then I fill in "field_s_session_date_time[und][0][value2][date]" with "03/31/2019"
    Then I fill in "field_s_session_date_time[und][0][value2][time]" with "02:00pm"
    Then I fill in "field_s_session_speaker[und][0][field_s_speaker_name][und][0][title]" with "Mark Twain"
    Then I fill in "field_s_session_speaker[und][0][field_s_speaker_name][und][0][url]" with "https://www.stanford.edu"
    Then I attach the file "img/ooooaaaahhh.jpg" to "edit-field-s-session-speaker-und-0-field-s-speaker-image-und-0-upload"
    Then I fill in "field_s_session_speaker[und][0][field_s_speaker_organization][und][0][value]" with "This is the organization"
    Then I fill in "field_s_session_speaker[und][0][field_s_speaker_topic][und][0][value]" with "This is the topic"
    # And the iframe in element "cke_contents_edit-field-s-session-speaker-und-0-field-s-speaker-description-und-0-value" has id "myid"
    # And I fill in "Bacon ipsum dolor sit amet deserunt fatback in venison" in WYSIWYG editor "myid"
    And I press the "Save" button
    Then I should see "Conference Session Behat Session One has been created"

    Then I go to "node/add/stanford-conference-session"
    Then I fill in "edit-title" with "Behat Session Two"
    And I select "Conference Overview Behat" from "edit-field-s-session-conference-und"
    Then I fill in "field_s_session_date_time[und][0][value][date]" with "04/01/2019"
    Then I fill in "field_s_session_date_time[und][0][value][time]" with "9:00am"
    Then I fill in "field_s_session_date_time[und][0][value2][date]" with "04/01/2019"
    Then I fill in "field_s_session_date_time[und][0][value2][time]" with "11:00am"
    Then I fill in "field_s_session_speaker[und][0][field_s_speaker_name][und][0][title]" with "Sloof Lirpa"
    Then I fill in "field_s_session_speaker[und][0][field_s_speaker_name][und][0][url]" with "https://www.stanford.edu"
    Then I attach the file "img/ooooaaaahhh.jpg" to "edit-field-s-session-speaker-und-0-field-s-speaker-image-und-0-upload"
    Then I fill in "field_s_session_speaker[und][0][field_s_speaker_organization][und][0][value]" with "This is the other organization"
    Then I fill in "field_s_session_speaker[und][0][field_s_speaker_topic][und][0][value]" with "This is the second topic"
    # And the iframe in element "cke_contents_edit-field-s-session-speaker-und-0-field-s-speaker-description-und-0-value" has id "myid"
    # And I fill in "Bacon ipsum dolor sit amet deserunt fatback in venison" in WYSIWYG editor "myid"
    And I press the "Save" button
    Then I should see "Conference Session Behat Session Two has been created"

    Then I go to "conferences/conference-overview-behat"
    Then I should see "Conference Overview Behat"
    Then I should see "My Reg Link Title"
    Then I should see a ".field-name-field-s-conference-date" element
    Then I should see a ".field-name-field-s-conference-location" element
    Then I should see a ".field-name-field-s-conference-map-link" element
    Then I should see a ".view-s-conference-link-to-agenda" element
    Then I should see a ".view-conference-image" element
    Then I should see a ".view-conference-contact-info" element
    Then I should see a "#block-views-conference-sponsors-block" element

    Then I go to "conferences/conference-overview-behat/agenda"
    Then I should see "Agenda: Conference Overview Behat"
    Then I should see "March 31, 2019"
    Then I should see "April 1, 2019"
    Then I should see "Behat Session One"
    Then I should see "Behat Session Two"
    Then I should see a ".view-conference-link-to-overview" element

    Then I cleanup the "conferences/conference-overview-behat" alias
    Then I cleanup the "conferences/session-behat-session-one" alias
    Then I cleanup the "conferences/session-behat-session-two" alias
