Feature: Ensure items on the Testimonial Blocks Catalog page appear as expected
  In order to ensure items on the Testimonial Blocks Catalog page appear as expected
  As an administrator
  I want to be able to view all the Testimonial Blocks Catalog page blocks

  Background:
    Given I am logged in as a user with the "administrator" role
    Given I am on "catalog-patterns/blocks-and-beans/testimonial-blocks"

  @safe @api
  Scenario: Verify that the quote marks display and classes are correct.
    Then I should see a "#block-bean-jumpstart-homepage-testimonial-b" element
    Then I should see a "#block-bean-jumpstart-homepage-testimonial-b .group-s-quote-style" element
    Then I should see a "#block-bean-jumpstart-homepage-testimonial-b.span12.next-row.well.no-padding" element
    Then I should see a "#block-bean-jumpstart-homepage-testimonial-b .group-s-more-link-style" element

  @safe @api
  Scenario: Verify that the quote marks don't display when there's no text and classes are correct.
    Then I should see a "#block-bean-test-testimonial-block-with-no-q" element
    Then I should not see "#block-bean-test-testimonial-block-with-no-q .group-s-quote-style"
    Then I should see a "#block-bean-test-testimonial-block-with-no-q.span12.next-row.well.no-padding" element
    Then I should see a "#block-bean-test-testimonial-block-with-no-q .group-s-more-link-style" element

