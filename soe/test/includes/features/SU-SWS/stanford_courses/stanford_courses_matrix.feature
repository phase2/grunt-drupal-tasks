Feature: Stanford Course Matrix
  In order to ensure that stanford courses was installed succesfully.
  As an administrative user
  I want to ensure that the Stanford Courses Matrix module is working properly

  @api @safe
  Scenario: Stanford Courses Matrix
    Given I am logged in as a user with the "administrator" role
    And I am on "admin/structure/views/view/stanford_courses_matrix"
    Then I should see "Course Matrix"
