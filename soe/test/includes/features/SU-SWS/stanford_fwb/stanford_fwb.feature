Feature: Stanford Full Width Banner
  In order to ensure that the full width banner pages are viewable
  As a visitor to the site I want to be able to view pages.

@api @dev @destructive @javascript
Scenario: Test Full width banner
  Given I am logged in as a user with the "administrator" role
  And I am on "admin/structure/views/view/stanford_slides_full_width_banner/edit"
  Then I should see "Stanford Slides: Full Width Banner"
  Then I am on "node/add/stanford-slide"
  Then I fill in "title" with "Behat Slide Test"
  And I attach the file "features/stanford_fwb/img/ooooaaaahhh.jpg" to "files[field_s_image_info_und_0_field_s_image_image_und_0]"
  And I press the "Save" button
  Then I should see "Behat Slide Test"
  Then I am on "admin/structure/context/add"
  And I fill in "name" with "behat_slide_test"
  And I select "Path" from "conditions[selector]"
  And I fill in "conditions[plugins][path][values]" with "<front>"
  And I select "Blocks" from "reactions[selector]"
  And I click on the element with css selector "#edit-reactions-plugins-block-selector-views a.fieldset-title"
  And I check the box "reactions[plugins][block][selector][views][checkboxes][views-9530832697bc4866adbecb898b8ca7db]"
  And I check the box "reactions[plugins][block][selector][views][checkboxes][views-1f87e2dcc30fc97e768620420853a031]"
  Then I click on the element with css selector ".context-blockform-regionlabel-content a.add-block"
  Then I press the "Save" button
  Then I should be on "admin/structure/context"
  And I should see "behat_slide_test"
  Then I am on the homepage
  And I should see 1 or more ".view-stanford-slides-full-width-banner.view-display-id-block img" elements
  And I should see 1 or more ".view-stanford-slides-full-width-banner.view-display-id-midget_block_caption_credits_below img" elements
  Then I am on "admin/structure/context/list/behat_slide_test/delete"
  And I press the "Delete" button




