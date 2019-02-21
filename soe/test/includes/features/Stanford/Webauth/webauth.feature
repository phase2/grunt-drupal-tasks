Feature: WebAuth
  Test that webauth is on the site

  Scenario: User
    Given I am on "/user"
    Then I should see the text "Log in with WebAuth" in the "Content" region