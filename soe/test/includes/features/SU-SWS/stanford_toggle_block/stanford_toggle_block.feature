Feature: Stanford Toggle Block
  In order to create toggle blocks on pages
  As an authenticated user
  I want to be able to add a toggle block

@api @javascript @dev @destructive
Scenario: See the subsite module settings page
  Given I am logged in as a user with the "administrator" role
  And I am on "block/add/stanford-toggle-block"
  And I fill in "edit-label" with "toggle block"
  And I fill in "edit-title" with "toggle block"
  And I click on the element with css selector "#edit-field-s-toggle-tab-und-add-more"
  And I fill in "edit-field-s-toggle-tab-und-0-field-s-toggle-link-label-und-0-value--2" with "link1"
  And I attach the file "img/ooooaaaahhh.jpg" to "files[field_s_toggle_tab_und_0_field_s_toggle_image_und_0]"
  And I fill in "edit-field-s-toggle-tab-und-1-field-s-toggle-link-label-und-0-value" with "link2"
  And I press the "Save" button
  Then I should see "toggle block" in the "Content Head" region
  And I should see "Toggle Block toggle block has been created" in the "Console" region
  When I click "link2"
  And I click "link1"
  And I wait 1 second
  Then I should see the "img" element in the "Content Body" region
  Given I am logged in as a user with the "site owner" role
  And I am on "block/toggle-block/edit"
  Then I should not see the text "Access Denied"
  Given I am logged in as a user with the "editor" role
  And I am on "block/toggle-block/edit"
  Then I should not see the text "Access Denied"
  Given I am logged in as a user with the "administrator" role
  And I am on "block/toggle-block/edit"
  And I click on the element with css selector "#edit-delete"
  And I click on the element with css selector "#edit-submit"
  Then I should see "Toggle Block toggle block has been deleted" in the "Console" region
