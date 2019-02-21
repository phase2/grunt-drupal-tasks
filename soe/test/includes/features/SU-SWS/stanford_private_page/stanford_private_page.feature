Feature: Stanford Private Page
  In order to ensure that the Stanford Private Page as administrator I want to verify I can create a private page.

  @api @dev @destructive
  Scenario: Adminstrator can create and edit Private Page types
    Given I am logged in as a user with the "administrator" role
    When I go to "node/add/stanford-private-page"
    Then I should see "Create Private Page" in the "Branding" region
    Then I fill in "edit-title" with "Bar"
    Then I attach the file "img/ooooaaaahhh.jpg" to "edit-field-s-image-info-und-0-field-s-image-image-und-0-upload"
    Then I press "Upload"
    Then I press "Save"
    Then I should be on "private/bar"
    Then I go to "admin/manage/private-page"
    Then I click on the element with css selector ".views-row-first .views-field-title a"
    Then I click "Edit" in the "Tabs" region
    Then I press "Save"
    And I should see "Bar" in the "Content Head" region
    And I should be on "private/bar"
    And I click "Edit" in the "Content Head" region
    And I click on the element with css selector "#edit-delete"
    And I click on the element with css selector "#edit-submit"
    Then I should see the text "Private Page Bar has been deleted" in the "Console" region


    @api @dev @destructive
    Scenario: Adminstrator can upload a file and anonymous user cannot access file
      Given I am logged in as a user with the "administrator" role
      When I go to "node/add/stanford-private-page"
      Then I should see "Create Private Page" in the "Branding" region
      Then I fill in "edit-title" with "Testing Private Page Permissions"
      Then I attach the file "files/sample.pdf" to "edit-field-s-private-file-und-0-upload"
      Then I press "Upload"
      Then I attach the file "img/ooooaaaahhh.jpg" to "edit-field-s-image-info-und-0-field-s-image-image-und-0-upload"
      Then I press "Upload"
      Then I press "Save"
      Then I should be on "private/testing-private-page-permissions"

      Given I am an anonymous user
      And I am on the homepage
      Then I go to "system/files/ooooaaaahhh.jpg"
      Then I should not see "bottom-logo"
      Then I go to "system/files/sample.pdf"
      Then I should not see "bottom-logo"
      When I go to "private/testing-private-page-permissions"
      Then I should not see "Testing Private Page Permissions"

      Given I am logged in as a user with the "administrator" role
      When I go to "private/testing-private-page-permissions"
      And I click "Edit" in the "Content Head" region
      And I click on the element with css selector "#edit-delete"
      And I click on the element with css selector "#edit-submit"
      Then I should see the text "Private Page Testing Private Page Permissions has been deleted" in the "Console" region


  @api @safe
  Scenario: As a administrator I can see Create Private Page
    Given I am logged in as a user with the "administrator" role
    When I go to "node/add/stanford-private-page"
    Then I should see "Create Private Page" in the "Branding" region
