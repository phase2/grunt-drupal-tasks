Feature: Stanford Courses Tag Translate
  In order to ensure that stanford courses tag translation works.
  As an administrative user
  I want to ensure that the Stanford Courses Tag Translate module is working properly

  @api @safe
  Scenario: Validate main admin page is there.
    Given I am logged in as a user with the "administrator" role
    And I am on "admin/config/stanford/courses/tag-translate"
    Then I should see "New tag translation"

  @api @safe
  Scenario: Validate import admin page is there.
    Given I am logged in as a user with the "administrator" role
    And I am on "admin/config/stanford/courses/tag-translate/import"
    Then I should see "Import" in the "Content" region

  @api @safe
  Scenario: Validate Export admin page is there.
    Given I am logged in as a user with the "administrator" role
    And I am on "admin/config/stanford/courses/tag-translate/export"
    # No content on this page is permanent so it is impossible to check for some without a scenario breaking.

  @api @dev @destructive
  Scenario: Import content
    Given I am logged in as a user with the "administrator" role
    Given I am on "admin/config/stanford/courses/tag-translate/import"
    Given I fill in "Import" with
    """
    {
      "IR::intlsec": "Translation One",
      "IR::wim": "This is Three",
      "IR::core": "I am translation Two"
    }
    """
    Then I press "Import"
    Then I should be on "admin/config/stanford/courses/tag-translate"
    And I should see "Import successful"
    And I should see "IR::intlsec"
    And I should see "IR::wim"
    And I should see "IR::core"

  @api @dev @destructive
  Scenario: Create tag translations
    Given I am logged in as a user with the "administrator" role
    And I am on "admin/config/stanford/courses/tag-translate"
    And I click "New tag translation"
    Then I should be on "admin/config/stanford/courses/tag-translate/new"
    Then I enter "ZZZZZ" for "edit-ctag"
    Then I enter "zzzzzzzZZZZZzzzzzz" for "edit-chuman"
    Then I press the "Save" button
    Then I should see "Tag translation was saved successfully"

  @api @dev @destructive
  Scenario: Delete tag translations
    Given I am logged in as a user with the "administrator" role
    And I am on "admin/config/stanford/courses/tag-translate"
    Then I click on the element with css selector "tr:last-child a[href*='/tag-translate/delete/']"
    Then I should see "This action cannot be un-done. Choose wisely."
    Then I press "Yes, delete this forever"
    Then I should see "Tag translation was successfully removed."
    Then I should be on "admin/config/stanford/courses/tag-translate"
    And I should see "Tag translation was successfully removed"

  # This scenario only works if the import scenario about has been run
  @api @dev @destructive
  Scenario: Edit tag translations
    Given I am logged in as a user with the "administrator" role
    And I am on "admin/config/stanford/courses/tag-translate"
    Then I click on the element with css selector "tr:first-child a[href*='/tag-translate/edit/']"
    Then I should see "Edit tag translation"
    Then I enter "MCS::BIOTRACK_CORE" for "edit-ctag"
    Then I enter "Biology Track Core" for "edit-chuman"
    Then I press "Save"
    Then I go to "admin/config/stanford/courses/tag-translate"
    And I should see "Biology Track Core"

  @api @dev @javascript @destructive
  Scenario: Validate translations
    Given I am logged in as a user with the "administrator" role
    And the cache has been cleared
    Given I am on "node/add/stanford-course-importer"
    Given I fill in "URL " with "http://explorecourses.stanford.edu/search?view=xml-20130201&filter-coursestatus-Active=on&page=0&catalog=&academicYear=&q=IR%3A%3Awim&collapse="
    And I fill in "Title" with "BeHat Test Course Importer"
    Then I press "Save"
    And I wait for the batch job to finish

  # Relies on the above test
  @api @dev @destructive @mytest
  Scenario: Validate translations
    Given I am logged in as a user with the "administrator" role
    Then I go to "admin/content"
    Then I click "International Law and International Relations"
    Then I click "Edit"
    Then I should see "Translation One"
    And I should see "This is Three"
