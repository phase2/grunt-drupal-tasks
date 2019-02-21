Feature: Stanford Course Views
  In order to ensure that stanford courses was installed succesfully.
  As an administrative user
  I want to ensure that the Stanford Courses Views module is working properly

  @api @safe
  Scenario: Stanford Course Views
    Given I am logged in as a user with the "administrator" role
    And I am on "admin/structure/views/view/courses"
    Then I should see "Courses Non-reference"
