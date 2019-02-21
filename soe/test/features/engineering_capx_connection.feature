Feature: Ensure the "View full profile on Stanford Profiles" button appears on a CAP imported profile
indicating that CAPx is connected for the profile
  In order to ensure that CAPx is connected for a profile
  As a Site User
  I want to be able to view the "View full profile on Stanford Profiles" button on a CAP imported
  profile

  @safe
  Scenario: Verify users can view the "View full profile on Stanford Profiles" button on a CAP imported profile
    Given I am on "people/russ-b-altman"
    Then I should see "Russ B. Altman" in the "Main Content" region
    And I should see 1 or more ".image-style-large-square" elements
    And I should see "View full profile on Stanford Profiles"
