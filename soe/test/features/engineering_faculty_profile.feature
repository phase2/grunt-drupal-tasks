Feature: Ensure the faculty profiles are appearing with images
  In order to ensure that the faculty profiles appear with images
  As a Site User
  I want to be able to view faculty images on their profiles

  @safe
  Scenario: Verify users can view the images on the faculty profiles
    Given I am on "people/faculty/grid"
    Then I should see "Faculty" in the "Main Content" region
    And I should see 1 or more ".view-content" elements
    And I should see 1 or more ".image-style-large-square" elements
