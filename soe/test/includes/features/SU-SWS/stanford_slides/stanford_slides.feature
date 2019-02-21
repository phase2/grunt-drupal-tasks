Feature: Stanford Slides
  In order to ensure that upgrades do not break existing functionality
  As an administrative user
  I want to ensure that the Stanford Slides module is working properly

  @api @javascript @dev @destructive
  Scenario: Stanford Slides
    Given I am logged in as a user with the "administrator" role
    And I am on "node/add/stanford-slide"
    When I enter "[random]" for "Title *"
    And I click "Add/Edit Image"
    And I attach the file "bacon.png" to "edit-field-s-image-info-und-0-field-s-image-image-und-0-upload"
    And I press the "Upload" button
    And I press the "Save" button
    Then I should see "Stanford Slide [random:1] has been created"
      # Scenario outline does some weird things with this loop, so not using it
    And I should see "Caption Color" in the "Content Body" region
    And I should see "Dark" in the "Content Body" region
    And I should see "Featured" in the "Content Body" region
    And I should see "Bottom" in the "Content Body" region
    And I should see "Left" in the "Content Body" region
    And I should see a ".view-mode-stanford-9-col-banner" element
