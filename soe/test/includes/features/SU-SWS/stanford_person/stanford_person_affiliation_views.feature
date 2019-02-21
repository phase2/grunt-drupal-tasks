Feature: Stanford Person Affiliation Views
  In order to ensure that the Stanford Person Affiliation views display properly
  As an end user
  I want to verify the display of people content.

  # @deploy Need to create the content before testing for it
  Scenario: Faculty node
    Given I am on "people/faculty"
    And I click "Jacob Smith" in the "Content Body" region
    Then I should see "Professor of English" in the "Content Body" region

  # @deploy Need to create the content before testing for it
  Scenario: Stanford Person node page
    Given I am on "people/jacob-smith"
    Then I should see a ".postcard-left" element

  # @deploy Need to create the content before testing for it
  Scenario: Faculty node on directory page and node page
    Given I am on "people/faculty/directory"
    And I click "Jacob Smith" in the "Content Body" region
    Then I should see "Professor of English" in the "Content Body" region

   # @deploy Need to create the content before testing for it
  Scenario: Staff node on profiles page and node page
    Given I am on "people/staff/profiles"
    And I click "Emily Jordan" in the "Content Body" region
    Then I should see "Department Manager" in the "Content Body" region

   # @deploy Need to create the content before testing for it
  Scenario: Staff node on grid page and node page
    Given I am on "people/staff/grid"
    And I click "Emily Jordan" in the "Content Body" region
    Then I should see "Department Manager" in the "Content Body" region

  # @deploy Need to create the content before testing for it
  Scenario: Staff node on directory page and node page
    Given I am on "people/staff/directory"
    And I click "Emily Jordan" in the "Content Body" region
    Then I should see "Department Manager" in the "Content Body" region

   # @deploy Need to create the content before testing for it
  Scenario: Students node on profiles page and node page
    Given I am on "people/students/profiles"
    And I click "Haley Jackson" in the "Content Body" region
    Then I should see "B.A., Stanford University, 2012" in the "Content Body" region

  # @deploy Need to create the content before testing for it
  Scenario: Students node on grid page and node page
    Given I am on "people/students/grid"
    And I click "Haley Jackson" in the "Content Body" region
    Then I should see "B.A., Stanford University, 2012" in the "Content Body" region

   # @deploy Need to create the content before testing for it
  Scenario: Students node on directory page and node page
    Given I am on "people/students/directory"
    And I click "Haley Jackson" in the "Content Body" region
    Then I should see "B.A., Stanford University, 2012" in the "Content Body" region

  # @deploy Need to create the content before testing for it
  Scenario: Faculty node on profiles page
    Given I am on "people/faculty/profiles"
    And I click "Jacob Smith" in the "Content Body" region
    Then I should see "Professor of English" in the "Content Body" region

  # @deploy Need to create the content before testing for it
  Scenario: Faculty taxonomy filter
    Given I am on "people/faculty"
    When I select "Professor" from "Filter by faculty status"
    And I press "Go"
    Then I should see "Jacob Smith" in the "Content Body" region
    And I should not see "Jane Doe" in the "Content Body" region

  @safe
  Scenario: List of staff
    Given I am on "people/staff"
    Then I should see a ".views-row-first" element
    And I should see a ".views-row-lines" element

  @safe
  Scenario: List of students
    Given I am on "people/students"
    Then I should see a ".views-row-first" element
    And I should see a ".views-row-lines" element

  @safe
  Scenario: Students layout
    Given I am on "people/students"
    Then I should see a ".views-exposed-form" element
    And I should see "People" in the "First sidebar" region

  @safe
  Scenario: Staff layout: exposed filter
    Given I am on "people/staff"
    Then I should see a ".views-exposed-form" element
    And I should see "People" in the "First sidebar" region
    And I should see "Contact and Location" in the "First sidebar" region


  # @deploy Need to create the content before testing for it
  Scenario: List of faculty
    Given I am on "people/faculty"
    Then I should see a ".views-row-first" element
    And I should see a ".views-row-lines" element
    And I should see the heading "Why I Teach" in the "First sidebar" region
    And I should see the "People" heading in the "First sidebar" region
    And I should see "This is your Why I Teach block" in the "First sidebar" region
