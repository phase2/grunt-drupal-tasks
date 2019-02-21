Feature: Ensure items on the Students and Academics landing page appear as expected
  In order to ensure items on the Students and Academics landing page appear as expected
  As a Site User
  I want to be able to view all the Students and Academics landing page blocks in their appropriate regions

  @safe
  Scenario: Verify users can view the top banner
    Given I am on "students-and-academics"
    Then I should see the "img" element in the "Top Full Width" region
    Then I should see 1 or more ".image-style-full-width-banner-short" elements

  @safe
  Scenario: Verify users can view the WYSIWYG text (and buttons)
    Given I am on "students-and-academics"
    Then I should see a ".field-name-body" element
    Then I should see the text "Your experiences at Stanford"
    Then I should see the text "More about the student experience"
    Then I should see the text "More about academics"
    Then I should see the text "Undergraduate resources"
    Then I should see the text "Graduate resources"
    Then I should see the text "Undergraduate Handbook"
