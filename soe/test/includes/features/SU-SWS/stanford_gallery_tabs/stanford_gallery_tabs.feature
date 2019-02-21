Feature: Gallery Tabs
  In order to ensure that the gallery tabs feature is on the home page
  As an authenticated user
  I want to check the customizations are present

@api @safe
Scenario: See gallery tabs on homepage
  Given I am on the homepage
  Then I should see a "#block-stanford-gallery-tabs-stanford-gallery-tabs" element
