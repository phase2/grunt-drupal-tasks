Feature: Stanford Course Administration
  In order to ensure that stanford courses was installed succesfully.
  As an administrative user
  I want to ensure that the Stanford Courses Administration module is working properly

  @api @safe
  Scenario: Stanford Courses Administration
    Given I am logged in as a user with the "administrator" role
    And I am on "admin/structure/views/view/courses"
    Then I should see "Courses: Manage"
