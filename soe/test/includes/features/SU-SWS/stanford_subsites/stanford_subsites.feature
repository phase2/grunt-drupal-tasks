Feature: Stanford Subsites
  In order to make uniquely branded sections of a website
  As an authenticated user
  I want to be able to make and view subsites

@api @javascript @safe
Scenario: See the subsite module settings page
  Given I am logged in as a user with the "administrator" role
  And I am on "admin/config/subsites"
  Then I should see "SUBSITE MENU PLACEMENT" in the "Content Body" region

@api @javascript @safe
Scenario: See manage subsites in the shortcuts
  Given I am logged in as a user with the "site owner" role
  And I am on the homepage
  When I click "Manage Subsites" in the "Admin Shortcuts" region
  Then I should be on "admin/config/subsites/dashboard"

@api @javascript @safe
Scenario: Ability to Add Subsite
  Given I am logged in as a user with the "site owner" role
  And I am on the homepage
  When I click "Site Actions" in the "Admin Shortcuts" region
  Then I should see "Add Subsite" in the "Content Body" region

@api @javascript @destructive
Scenario: Create subsite content
  Given I am logged in as a user with the "administrator" role
  And I am on "node/add/stanford-subsite"
  And I fill in "Site Name" with "Behat"
  And I fill in "Site Name Second Line" with "Subsite"
  And I fill in "Page Title" with "The Bees Knees"
  And I fill in "Subsite Tag" with "behat"
  Then I click "Subsite Branding options"
  And I fill in "Subsite Slogan" with "Slow logan"
  And I press "Save"
  Then I should see "A Menu for this subsite was successfully created." in the "Content Head" region
  Then I should see "The Menu block has been created" in the "Content Head" region
  Then I should see "A subsite context was created for you" in the "Content Head" region
  Then I should see "Subsite The Bees Knees has been created" in the "Content Head" region
  Then I should see 1 ".node-type-stanford-subsite" element
  Then I should see 1 "#site-title-first-line" element
  Then I should see 1 "#site-title-second-line" element
  Then I should see 1 "#site-slogan" element

@api @javascript @safe
Scenario: See subsite stuff
  Given I am logged in as a user with the "administrator" role
  And I am on "admin/content"
  And I select "Subsite" from "Type"
  Then I press "Apply"
  Then I should see 1 or more ".views-field" elements
  When I click on the element with css selector ".views-row-first .views-field-title a"
  Then I should see 1 ".node-type-stanford-subsite" element
  Then I should see 1 "#site-title-first-line" element
  Then I should see 1 ".block-menu-block" element in the "Main Navigation" region
  Then I should see 1 ".block-menu-block ul.menu li a" element in the "Main Navigation" region
