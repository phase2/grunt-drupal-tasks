Feature: Stanford Gallery
  In order to ensure that gallery nodes and beans can be created and the appropriate displays are available.
  as an administrator
  I want to be able to create gallery nodes with imagess.

@api @javascript @dev
Scenario: Create stanford gallery node
  Given I am logged in as a user with the "administrator" role
  And I am on "node/add/stanford-gallery"

  Then I fill in "edit-title" with "BeHat Test Gallery"
  Then I click on the element with css selector ".vertical-tabs-list li:nth-child(2) a" with javascript
  Then I select "Small" from "Thumbnail Size"
  Then I select "Large" from "Thumbnail Size"
  Then I select "Large Scaled" from "Thumbnail Size"
  Then I select "Medium" from "Thumbnail Size"
  Then I check "Show Captions"

  # Add each field collection element.
  Then I press "field_s_gallery_image_info_add_more"
  Then I wait for AJAX to finish
  Then I press "field_s_gallery_image_info_add_more"
  Then I wait for AJAX to finish
  Then I press "field_s_gallery_image_info_add_more"
  Then I wait for AJAX to finish
  Then I press "field_s_gallery_image_info_add_more"
  Then I wait for AJAX to finish
  Then I press "field_s_gallery_image_info_add_more"
  Then I wait for AJAX to finish

  # Images
  Then I attach the file "img/ooooaaaahhh.jpg" to "edit-field-s-gallery-image-info-und-0-field-s-image-image-und-0-upload--6"
  Then I attach the file "img/ooooaaaahhh.jpg" to "edit-field-s-gallery-image-info-und-1-field-s-image-image-und-0-upload--5"
  Then I attach the file "img/ooooaaaahhh.jpg" to "edit-field-s-gallery-image-info-und-2-field-s-image-image-und-0-upload--4"
  Then I attach the file "img/ooooaaaahhh.jpg" to "edit-field-s-gallery-image-info-und-3-field-s-image-image-und-0-upload--3"
  Then I attach the file "img/ooooaaaahhh.jpg" to "edit-field-s-gallery-image-info-und-4-field-s-image-image-und-0-upload--2"
  Then I attach the file "img/ooooaaaahhh.jpg" to "edit-field-s-gallery-image-info-und-5-field-s-image-image-und-0-upload"

  Then I press "Save"
  Then I should see "Gallery BeHat Test Gallery has been created."
  Then I click "Edit"

  # Swtich to images tab.
  Then I click on the element with css selector ".vertical-tabs-list li:nth-child(2) a" with javascript

  # Expand each option.
  Then I click on the element with css selector ".field-name-field-s-gallery-image-info .field-multiple-table tr:nth-child(1) a.fieldset-title" with javascript
  Then I click on the element with css selector ".field-name-field-s-gallery-image-info .field-multiple-table tr:nth-child(2) a.fieldset-title" with javascript
  Then I click on the element with css selector ".field-name-field-s-gallery-image-info .field-multiple-table tr:nth-child(3) a.fieldset-title" with javascript
  Then I click on the element with css selector ".field-name-field-s-gallery-image-info .field-multiple-table tr:nth-child(4) a.fieldset-title" with javascript
  Then I click on the element with css selector ".field-name-field-s-gallery-image-info .field-multiple-table tr:nth-child(5) a.fieldset-title" with javascript
  Then I click on the element with css selector ".field-name-field-s-gallery-image-info .field-multiple-table tr:nth-child(6) a.fieldset-title" with javascript

  # Captions
  Then I fill in "field_s_gallery_image_info[und][0][field_s_image_caption][und][0][value]" with "This is caption 0"
  Then I fill in "field_s_gallery_image_info[und][1][field_s_image_caption][und][0][value]" with "This is caption 1"
  Then I fill in "field_s_gallery_image_info[und][2][field_s_image_caption][und][0][value]" with "This is caption 2"
  Then I fill in "field_s_gallery_image_info[und][3][field_s_image_caption][und][0][value]" with "This is caption 3"
  Then I fill in "field_s_gallery_image_info[und][4][field_s_image_caption][und][0][value]" with "This is caption 4"
  Then I fill in "field_s_gallery_image_info[und][5][field_s_image_caption][und][0][value]" with "This is caption 5"

  # Credits
  Then I fill in "field_s_gallery_image_info[und][0][field_s_image_credits][und][0][value]" with "credit 1"
  Then I fill in "field_s_gallery_image_info[und][1][field_s_image_credits][und][0][value]" with "credit 2"
  Then I fill in "field_s_gallery_image_info[und][2][field_s_image_credits][und][0][value]" with "credit 3"
  Then I fill in "field_s_gallery_image_info[und][3][field_s_image_credits][und][0][value]" with "credit 4"
  Then I fill in "field_s_gallery_image_info[und][4][field_s_image_credits][und][0][value]" with "credit 5"
  Then I fill in "field_s_gallery_image_info[und][5][field_s_image_credits][und][0][value]" with "credit 6"

  # Save the Node
  Then I press "Save"

  # Confirm Node has been created
  # Then I should see "Gallery BeHat Test Gallery has been created." in the "Content Head" region
  Then I should be on "behat-test-gallery"

  # Test for the images.
  Then I should see 6 or more ".stanford-gallery-image" elements
  Then I click on the element with css selector ".field-name-field-s-gallery-image-info .field-item:nth-child(1) .stanford-gallery-image" with javascript

  Then I should see 1 "#colorbox" element
  When I hover over the element "#cboxContent"
  And I wait for AJAX to finish
  # TODO: Make these work...
  # Then I should see 1 "#colorbox .caption" element
  # Then I should see 1 "#colorbox .credits" element
  Then I click on the element with css selector "#cboxNext"
  And I wait for AJAX to finish
  Then I click on the element with css selector "#cboxNext"
  And I wait for AJAX to finish
  Then I click on the element with css selector "#cboxNext"
  And I wait for AJAX to finish
  Then I click on the element with css selector "#cboxNext"
  And I wait for AJAX to finish
  Then I click on the element with css selector "#cboxNext"
  And I wait for AJAX to finish
  Then I click on the element with css selector "#cboxClose"
  And I wait for AJAX to finish
  Then I should be on "behat-test-gallery"
  And I should see "Behat Test Gallery"
