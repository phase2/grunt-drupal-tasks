Feature: Stanford Courses
  In order to ensure that stanford courses was installed succesfully.
  As an administrative user
  I want to ensure that the Stanford Courses module is working properly

  @api @safe
  Scenario: Stanford Courses
    Given I am logged in as a user with the "administrator" role
    Then I am on "admin/structure/field-collections/field_s_course_section_info/fields"
    And I should see "field_s_course_co_person"
    And I should see "field_s_course_component"
    And I should see "field_s_course_dow"
    And I should see "field_s_course_instructor"
    And I should see "field_s_course_location"
    And I should see "field_s_course_section_class_id"
    And I should see "field_s_course_section_dates"
    And I should see "field_s_course_section_number"
    And I should see "field_s_course_section_year"
    And I should see "field_s_course_syllabus"
    And I should see "field_s_course_term"
    And I should see "field_s_course_time"
    And I should see "field_s_course_time_end"
    And I should see "field_s_course_units"
    And I should see "field_s_course_year_computed"

    Then I am on "admin/structure/field-collections/field_s_course_section_info/display/default"
    And I want to validate select field option "fields[field_s_course_co_person][type]" default value is "text_default"
    And I want to validate select field option "fields[field_s_course_component][type]" default value is "hidden"
    And I want to validate select field option "fields[field_s_course_dow][type]" default value is "text_default"
    And I want to validate select field option "fields[field_s_course_instructor][type]" default value is "text_default"
    And I want to validate select field option "fields[field_s_course_location][type]" default value is "text_default"
    And I want to validate select field option "fields[field_s_course_section_class_id][type]" default value is "hidden"
    And I want to validate select field option "fields[field_s_course_section_dates][type]" default value is "hidden"
    And I want to validate select field option "fields[field_s_course_section_number][type]" default value is "number_integer"
    And I want to validate select field option "fields[field_s_course_section_year][type]" default value is "list_default"
    And I want to validate select field option "fields[field_s_course_syllabus][type]" default value is "file_default"
    And I want to validate select field option "fields[field_s_course_term][type]" default value is "list_default"
    And I want to validate select field option "fields[field_s_course_time][type]" default value is "text_default"
    And I want to validate select field option "fields[field_s_course_time_end][type]" default value is "text_default"
    And I want to validate select field option "fields[field_s_course_units][type]" default value is "text_default"
    And I want to validate select field option "fields[field_s_course_year_computed][type]" default value is "hidden"

    Then I am on "admin/structure/types/manage/stanford_course/fields"
    And I should see "body"
    And I should see "field_s_course_code"
    And I should see "field_s_course_code_integer"
    And I should see "field_s_course_ec_link"
    And I should see "field_s_course_ec_tag"
    And I should see "field_s_course_ger"
    And I should see "field_s_course_grading"
    And I should see "field_s_course_id"
    And I should see "field_s_course_scid"
    And I should see "field_s_course_section_info"
    And I should see "field_s_course_subject"
    And I should see "field_s_course_tag_name"
    And I should see "field_s_course_tag_org"
    And I should see "field_s_course_year"

    Then I am on "admin/structure/types/manage/stanford_course/display/default"
    And I want to validate select field option "fields[body][type]" default value is "text_default"
    And I want to validate select field option "fields[field_s_course_code][type]" default value is "text_plain"
    And I want to validate select field option "fields[field_s_course_code_integer][region]" default value is "hidden"
    And I want to validate select field option "fields[field_s_course_ec_link][type]" default value is "link_default"
    And I want to validate select field option "fields[field_s_course_ec_tag][region]" default value is "hidden"
    And I want to validate select field option "fields[field_s_course_ger][type]" default value is "text_default"
    And I want to validate select field option "fields[field_s_course_grading][type]" default value is "text_default"
    And I want to validate select field option "fields[field_s_course_id][type]" default value is "number_integer"
    And I want to validate select field option "fields[field_s_course_scid][region]" default value is "hidden"
    And I want to validate select field option "fields[field_s_course_section_info][type]" default value is "field_collection_view"
    And I want to validate select field option "fields[field_s_course_subject][type]" default value is "text_default"
    And I want to validate select field option "fields[field_s_course_tag_name][region]" default value is "hidden"
    And I want to validate select field option "fields[field_s_course_tag_org][region]" default value is "hidden"
    And I want to validate select field option "fields[field_s_course_year][region]" default value is "hidden"

    Then I am on "admin/structure/types/manage/stanford_course/display/teaser"
    And I want to validate select field option "fields[body][type]" default value is "hidden"
    And I want to validate select field option "fields[field_s_course_code][type]" default value is "hidden"
    And I want to validate select field option "fields[field_s_course_code_integer][type]" default value is "hidden"
    And I want to validate select field option "fields[field_s_course_ec_link][type]" default value is "hidden"
    And I want to validate select field option "fields[field_s_course_ec_tag][type]" default value is "hidden"
    And I want to validate select field option "fields[field_s_course_ger][type]" default value is "hidden"
    And I want to validate select field option "fields[field_s_course_grading][type]" default value is "hidden"
    And I want to validate select field option "fields[field_s_course_id][type]" default value is "hidden"
    And I want to validate select field option "fields[field_s_course_scid][type]" default value is "hidden"
    And I want to validate select field option "fields[field_s_course_section_info][type]" default value is "hidden"
    And I want to validate select field option "fields[field_s_course_subject][type]" default value is "hidden"
    And I want to validate select field option "fields[field_s_course_tag_name][type]" default value is "hidden"
    And I want to validate select field option "fields[field_s_course_tag_org][type]" default value is "hidden"
    And I want to validate select field option "fields[field_s_course_year][type]" default value is "hidden"

  @api @dev
  Scenario: Create courses and see if they exist on the page.
    Given I am logged in as a user with the "administrator" role
    And I am on "node/add/stanford-course"
    Then I fill in "Title" with "Courses Behat Test"
    And I select "2014-2015" from "field_s_course_section_info[und][0][field_s_course_section_year][und]"
    Then I press the "Save" button
    And I should see "Courses Behat Test"
    Then the cache has been cleared
    And I am on "courses/search?field_s_course_section_year_value=2014"
    And I should see "Courses Behat Test"
    When I am on "courses/search?combine=UnderwaterBasket"
    Then I should see "No courses are available based on your search." in the "Content Body" region

  @api @javascript @dev
  Scenario: Stanford Courses
    Given I am logged in as a user with the "administrator" role
    And the cache has been cleared
    And I am on "node/add/stanford-course-importer"
    When I enter "IR WIM Courses" for "Title"
    And I enter "http://explorecourses.stanford.edu/search?view=catalog&filter-coursestatus-Active=on&page=0&catalog=&academicYear=&q=IR%3A%3Awim&collapse=" for "URL"
    And I press the "Save" button
    And I wait for the batch job to finish
    Then I should see "Course Importer IR WIM Courses has been created"
    When I click "Delete items"
    And I press the "Delete" button
    And I wait for the batch job to finish
    Then I should see "Deleted"
