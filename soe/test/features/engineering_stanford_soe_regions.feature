Feature: SOE Regions Module
  In order to ensure the Stanford SOE Regions module is working properly
  As an end user
  I want to check for the existence of the new regions

  @api @safe @javascript
  Scenario: Test for the Digital Magazine Menu region
    Given I am on "magazine"
#    And I wait for AJAX to finish
#    And I should see "Topics" in the "Digital Magazine Menu" region

    @api @safe @javascript
    Scenario: Test for the Digital Magazine Megamenu region
      Given I am on "magazine"
#      And I wait for AJAX to finish
#      Then I click on the element with css selector ".menu-name-menu-magazine ul a:nth-child(1)" with javascript
#      And I wait for AJAX to finish
#      Then I should see "Health" in the "Digital Magazine Megamenu" region
