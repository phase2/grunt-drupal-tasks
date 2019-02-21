Feature: Homepage carousel Javascript
 In order to ensure that the Art and Art History website homepage carousel is navigable
 As an end user
 I want to interact with dynamic Javascript of the homepage carousel

# The carousel is random, so there's no good way to assert what text will be present
# This test should be observed visually
@javascript @live
Scenario: Homepage carousel
 Given I am on the homepage
  When I press the "Next Slide" button
   And I wait 2 seconds
 Then I should see a ".slide-title" element
  When I press the "Next Slide" button
   And I wait 2 seconds
 Then I should see a ".slide-title" element
  When I press the "Next Slide" button
   And I wait 2 seconds
 Then I should see a ".slide-title" element
  When I press the "Next Slide" button
   And I wait 2 seconds
 Then I should see a ".slide-title" element
  When I press the "Next Slide" button
   And I wait 2 seconds
 Then I should see a ".slide-title" element
 When I press the "Previous Slide" button
   And I wait 2 seconds
 Then I should see a ".slide-title" element

 @javascript @live
 Scenario: Homepage carousel works with ">" and "<"
  Given I am on the homepage
  When I press the "›" button
  And I wait 2 seconds
  Then I should see a ".slide-title" element
  When I press the "‹" button
  And I wait 2 seconds
  Then I should see a ".slide-title" element
