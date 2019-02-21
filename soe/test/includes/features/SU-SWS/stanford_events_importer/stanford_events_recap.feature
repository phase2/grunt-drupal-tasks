Feature: Stanford Events Recap
  In order to validate the funcationlity of recap
  As an administrative user
  I want to check the fields exists and work.

  @api @dev @safe
  Scenario: Test the recap fields.
    Given the "stanford_events_recap" module is enabled
    And I am logged in as a user with the "administrator" role
    And I am on "admin/structure/types/manage/stanford-event/fields"
    Then I should see "group_post_events"
    And I should see "field_s_event_post_video"
    And I should see "field_s_event_post_audio"
    And I should see "field_s_event_post_gallery"
    And I should see "field_s_event_post_recap"
    Then I am on "node/add/stanford-event"
    And I fill in the following:
      | title                                       | [random]                    |
      | field_s_event_post_video[und][0][video_url] | https://youtu.be/G6ymv0aYEdM  |
      | field_s_event_post_audio[und][0][url]       | google.com                    |
      | field_s_event_post_gallery[und][0][url]     | google.com                    |
      | field_s_event_post_recap[und][0][title]     | Recap Link 1                  |
      | field_s_event_post_recap[und][0][url]       | google.com                    |
    Then I press the "Save" button
    And I should see "Event Recap"
    And I should see 1 ".field-name-field-s-event-post-video iframe" element
    And I should see "Download the audio"
    And I should see "View gallery"
    And I should see "Recap Link 1"
