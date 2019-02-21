<?php
/**
 * @file
 */

use Behat\Behat\Context\Context,
  Behat\Behat\Context\SnippetAcceptingContext,
  Behat\Behat\Context\ClosuredContextInterface,
  Behat\Behat\Context\TranslatedContextInterface,
  Behat\Behat\Context\BehatContext,
  Behat\Behat\Context\TranslatableContext,
  Behat\Behat\Exception\PendingException,
  Behat\Behat\Hook\Scope\BeforeScenarioScope;

use Behat\Mink\Exception\ExpectationException,
  Behat\Mink\Session;

use Behat\Gherkin\Node\PyStringNode,
  Behat\Gherkin\Node\TableNode;

use Drupal\Component\Utility\Random;

use Drupal\DrupalExtension\Context\RawDrupalContext;

use SWSMinkContext as MinkContext;
use SWSDrupalContext as DrupalContext;

/**
 * Features context.
 */
class SWSFeatureContext extends RawDrupalContext implements Context, SnippetAcceptingContext {


  /**
   * Track changed variables so we can revert them back after we are done.
   *
   * @var array
   */
  private $changedVariables = array();


  /**
   * Helper function to return a string between two strings
   *
   * @param $haystack
   * @param $needle_start
   * @param $needle_end
   * @return bool|string
   */
  private function getStringBetween($haystack, $needle_start, $needle_end) {
    $start = strpos($haystack, $needle_start) + strlen($needle_start);
    $length = strpos($haystack, $needle_end, $start) - $start;
    $between = substr($haystack, $start, $length);
    return $between;
  }

  /**
   * @var \Drupal\DrupalExtension\Context\DrupalContext
   */
  protected $drupalContext;

  /**
   * @var \Drupal\DrupalExtension\Context\MinkContext
   */
  protected $minkContext;

  /**
   * @BeforeScenario
   */
  public function gatherContexts(BeforeScenarioScope $scope) {
    $environment = $scope->getEnvironment();
    $this->drupalContext = $environment->getContext('SWSDrupalContext');
    $this->minkContext = $environment->getContext('SWSMinkContext');
  }

  /**
   * @AfterScenario
   */
  public function after($event) {
    $user = $this->drupalContext->logout();
  }

  /**
   * Initializes context.
   *
   * Every scenario gets its own context object.
   *
   * @param array $parameters
   *   Context parameters (set them up through behat.yml).
   */
  public function __construct() {
    // Initialize your context here.
  }

  /**
   * @Given /^the "([^"]*)" module is enabled$/
   */
  public function theModuleIsEnabled($arg1) {
    $pmi = $this->getDriver()->drush('pm-info ' . $arg1);
    // This is a little ugly, but if the module is not found, $pmi is empty.
    // For some reason, it does not get populated with "<modulename> was not found [warning]".
    // So we check for the module name in the output of drush pm-info.
    $found = preg_match("/$arg1/", $pmi);
    if (!$found) {
      throw new Exception($pmi);
    }
    $enabled = preg_match('/Status\s{1,}\:\s{1,}enabled/', $pmi);
    if (!$enabled) {
      $result = $this->getDriver()->drush("pm-enable -y " . $arg1);
      if (preg_match('/\[error\]/', $result)) {
        throw new Exception($result);
      }
    }

  }

  /**
   * @Given /^the "([^"]*)" module is disabled$/
   */
  public function theModuleIsDisabled($arg1) {
    $result = $this->getDriver()->drush("pm-disable -y " . $arg1);
    if (preg_match('/\[error\]/', $result)) {
      throw new Exception($result);
    }
  }

  /**
   * @Given /^I wait (\d+) second(s)?$/
   */
  public function iWaitSeconds($seconds) {
    $mink = $this->minkContext;
    $mink->getSession()->wait(1000 * $seconds);
  }

  /**
   * Invoking a php code with drush.
   *
   * @param $function
   *   The function name to invoke.
   * @param $arguments
   *   Array contain the arguments for function.
   * @param $debug
   *   Set as TRUE/FALSE to display the output the function print on the
   *   screen.
   *   See
   *   https://github.com/openscholar/openscholar/blob/SCHOLAR-3.x/openscholar/behat/features/bootstrap/FeatureContext.php#L658
   */
  private function invoke_code($function, $arguments = NULL, $debug = FALSE) {
    $code = !empty($arguments) ? "$function(" . implode(',', $arguments) . ");" : "$function();";

    $output = $this->getDriver()->drush("php-eval \"{$code}\"");

    if ($debug) {
      print_r($output);
    }

    return $output;
  }


  /**
   * @Then /^I should see (\d+) or more "([^"]*)" elements$/
   */
  public function iShouldSeeOrMoreElements($num, $element) {

    $container = $this->getSession()->getPage();
    $nodes = $container->findAll('css', $element);
    $mink = $this->minkContext;
    $session = $mink->getSession();

    if (intval($num) > count($nodes)) {
      $message = sprintf('%d "%s" elements found when there should be a minimum of %d.', count($nodes), $element, $num);
      throw new ExpectationException($message, $session);
    }

  }

  /**
   * Find an element in a region.
   * see
   * http://cgit.drupalcode.org/panopoly/tree/tests/behat/features/bootstrap/FeatureContext.php?id=18a2ccbdad8c8064aa36f8c57ae7416ee018b92f.
   *
   * @Then /^I should see a "([^"]*)" element in the "([^"]*)" region$/
   */
  public function assertRegionElement($tag, $region) {

    $mink = $this->minkContext;
    $regionObj = $mink->getRegion($region);
    $elements = $regionObj->findAll('css', $tag);
    if (!empty($elements)) {
      return;
    }
    throw new \Exception(sprintf('The element "%s" was not found in the "%s" region on the page %s', $tag, $region, $this->getSession()
                                                                                                                         ->getCurrentUrl()));
  }

  /**
   * @Then /^I should see (\d+) "([^"]*)" element[s]? in the "([^"]*)" region$/
   */
  public function iShouldSeeElementsInTheRegion($num, $element, $region) {
    $mink = $this->minkContext;
    $regionObj = $mink->getRegion($region);
    $session = $mink->getSession();

    $selectElements = $regionObj->findAll(
      'xpath',
      $session->getSelectorsHandler()->selectorToXpath('css', $element)
    // Just changed xpath to css.
    );
    if (intval($num) !== count($selectElements)) {
      $message = sprintf('%d "%s" elements found when there should be %d.', count($selectElements), $element, $num);
      throw new ExpectationException($message, $session);
    }
  }

  /**
   * @Then /^I should see (\d+) or fewer "([^"]*)" elements$/
   */
  public function iShouldSeeOrFewerElements($num, $element) {
    $mink = $this->minkContext;
    $container = $mink->getSession()->getPage();
    $nodes = $container->findAll('css', $element);

    if (intval($num) < count($nodes)) {
      $session = $mink->getSession();
      $message = sprintf('%d "%s" elements found when there should be a maximum of %d.', count($nodes), $element, $num);
      throw new ExpectationException($message, $session);
    }
  }

  /**
   * @When /^I hover over the element "([^"]*)"$/
   */
  public function iHoverOverTheElement($locator) {
    $mink = $this->minkContext;
    $session = $mink->getSession();
    // Get the mink session.
    $element = $session->getPage()->find('css', $locator);
    // Runs the actual query and returns the element.

    // Errors must not pass silently.
    if (NULL === $element) {
      throw new \InvalidArgumentException(sprintf('Could not evaluate CSS selector: "%s"', $locator));
    }

    // ok, let's hover it.
    $element->mouseOver();
  }

  /**
   * This function causes the drop down. No need to add a hover step before.
   *
   * @Then /^I wait for the Site Actions drop down to appear$/
   */
  public function iWaitForTheSiteActionsDropDownToAppear() {
    $mink = $this->minkContext;

    $mink->getSession()->getDriver()->evaluateScript(
      "jQuery('#block-menu-menu-admin-shortcuts ul.nav li.first.last, #block-menu-menu-admin-shortcuts ul.nav li.expanded:first, #block-menu-menu-admin-shortcuts-site-action ul.nav li.expanded:first').find('ul').show().css('z-index', '1000');"
    );

    $mink->getSession()
         ->wait(3000, "jQuery('#block-menu-menu-admin-shortcuts ul.nav > ul.nav').children().length > 0");

  }

  /**
   * Click some text.
   *
   * @When /^I click on the text "([^"]*)"$/
   */
  public function iClickOnTheText($text) {
    $mink = $this->minkContext;
    $session = $mink->getSession();
    $element = $session->getPage()->find(
      'xpath',
      $session->getSelectorsHandler()
              ->selectorToXpath('xpath', '*//*[text()="' . $text . '"]')
    );
    if (NULL === $element) {
      throw new \InvalidArgumentException(sprintf('Cannot find text: "%s"', $text));
    }

    $element->click();
  }

  /**
   * Find the default value of a select element.
   * See https://github.com/Behat/Mink/issues/300.
   *
   * @Then /^I want to validate select field option "([^"]*)" default is "([^"]*)"$/
   */
  public function iWantToValidateSelectOptionDefaultIs($locator, $defaultValue) {
    $mink = $this->minkContext;
    $session = $mink->getSession();
    $page = $session->getPage();

    // //select[@id=\"$locator\"]/option[@selected]
    // //select[@class=\"$locator\"]/option[@selected]
    // //select[@name=\"$locator\"]/option[@selected]

    $element = $page->find("xpath", "//select[@id=\"$locator\"]/option[@selected]|//select[@class=\"$locator\"]/option[@selected]|//select[@name=\"$locator\"]/option[@selected]");
    if (!$element) {
      throw new Exception('Could not find a select element with an attribute of ' . $locator);
    }

    $selectedDefaultValue = (string) $element->getText();
    if ($selectedDefaultValue != $defaultValue) {
      throw new Exception('Select option default value: "' . $selectedDefaultValue . '" does not match given: "' . $defaultValue . '"');
    }
  }

  /**
   * Find the default value of a select element.
   * See https://github.com/Behat/Mink/issues/300.
   *
   * @Then /^I want to validate select field option "([^"]*)" default value is "([^"]*)"$/
   */
  public function iWantToValidateSelectOptionDefaultValueIs($locator, $defaultValue) {
    $mink = $this->minkContext;
    $session = $mink->getSession();
    $page = $session->getPage();

    // //select[@id=\"$locator\"]/option[@selected]
    // //select[@class=\"$locator\"]/option[@selected]
    // //select[@name=\"$locator\"]/option[@selected]

    $element = $page->find("xpath", "//select[@id=\"$locator\"]/option[@selected]|//select[@class=\"$locator\"]/option[@selected]|//select[@name=\"$locator\"]/option[@selected]");
    if (!$element) {
      throw new Exception('Could not find a select element with an attribute of ' . $locator);
    }


    $selectedDefaultValue = (string) $element->getValue();
    if ($selectedDefaultValue != $defaultValue) {
      throw new Exception('Select option default value: "' . $selectedDefaultValue . '" does not match given: "' . $defaultValue . '"');
    }
  }

  /**
   * @Given /^I wait for the Admin Menu to load$/
   * Wait until we have a "#admin-menu" element,
   * or timeout after 10 seconds (10,000 ms).
   */
  public function iWaitForTheAdminMenuToLoad() {
    $mink = $this->minkContext;
    $mink->getSession()->wait(10000, 'jQuery("#admin-menu").length > 0');
  }

  /**
   * Click on the element with the provided xpath query.
   *
   * @When /^I click on the element with xpath "([^"]*)"$/
   */
  public function iClickOnTheElementWithXPath($xpath) {
    $mink = $this->minkContext;
    $session = $mink->getSession();
    $element = $session->getPage()->find(
      'xpath',
      $session->getSelectorsHandler()->selectorToXpath('xpath', $xpath)
    );
    // Runs the actual query and returns the element.

    // Errors must not pass silently.
    if (NULL === $element) {
      throw new \InvalidArgumentException(sprintf('Could not evaluate XPath: "%s"', $xpath));
    }

    // ok, let's click on it.
    $element->click();

  }

  /**
   * Click on the element with the provided CSS Selector.
   *
   * @When /^I click on the element with css selector "([^"]*)"$/
   */
  public function iClickOnTheElementWithCSSSelector($css) {
    $mink = $this->minkContext;
    $session = $mink->getSession();
    $element = $session->getPage()->find('css', $css);

    if (NULL === $element) {
      throw new \InvalidArgumentException(sprintf('Could not evaluate CSS Selector: "%s"', $css));
    }
    $element->click();
  }

  /**
   * Click on the element with the provided CSS Selector.
   *
   * @When /^I click on the element with css selector "([^"]*)" with javascript$/
   */
  public function iClickOnTheElementWithCSSSelectorWithJavascript($css) {
    $mink = $this->minkContext;
    $session = $mink->getSession();
    $driver = $session->getDriver();

    $driver->evaluateScript(
      "jQuery('" . $css . "').click()"
    );
  }

  /**
   * Press the element with the provided CSS Selector.
   *
   * @When /^I press the element with css selector "([^"]*)"$/
   */
  public function iPressTheElementWithCSSSelector($css) {
    $mink = $this->minkContext;
    $session = $mink->getSession();
    $element = $session->getPage()->find('css', $css);
    if (NULL === $element) {
      throw new \InvalidArgumentException(sprintf('Could not evaluate CSS Selector: "%s"', $css));
    }
    $element->press();
  }

  /**
   * @Given /^I follow meta refresh$/
   */
  public function iFollowMetaRefresh() {
    $mink = $this->minkContext;
    while ($refresh = $mink->getSession()
                           ->getPage()
                           ->find('css', 'meta[http-equiv="Refresh"]')) {
      $content = $refresh->getAttribute('content');
      $url = str_replace('0; URL=', '', $content);
      $mink->getSession()->visit($url);
    }
  }

  /**
   * @When /^I select the "([^"]*)" radio button$/
   */
  public function iSelectTheRadioButton($labelText) {
    // Find the label by its text, then use that to get the radio item's ID.
    $radioId = NULL;
    $mink = $this->minkContext;
    $session = $mink->getSession();
    $page = $mink->getSession()->getPage();

    /** @var $label NodeElement */
    foreach ($session->getPage()->findAll('css', 'label') as $label) {
      if ($labelText === $label->getText()) {
        if ($label->hasAttribute('for')) {
          $radioId = $label->getAttribute('for');
          break;
        }
        else {
          throw new \Exception("Radio button's label needs the 'for' attribute to be set");
        }
      }
    }
    if (!$radioId) {
      throw new \InvalidArgumentException("Label '$labelText' not found.");
    }

    // Now use the ID to retrieve the button and click it.
    /** @var NodeElement $radioButton */
    $radioButton = $session->getPage()->find('css', "#$radioId");
    if (!$radioButton) {
      throw new \Exception("$labelText radio button not found.");
    }

    $page->fillField($radioId, $radioButton->getAttribute('value'));
  }

  /**
   * @Then I Select the :arg1 radio button with :arg2 value
   */
  public function iSelectTheRadioButtonWithValue($element, $value) {
    $page = $this->getSession()->getPage();
    $elements = $page->findAll('css', 'input[type="radio"][name="' . $element . '"]');

    if (!$element) {
      throw new \Exception("$element radio button not found.");
    }

    foreach ($elements as $radio) {
      if ($radio->getAttribute('value') == $value) {
        $page->fillField($radio->getAttribute('id'), $value);
        return TRUE;
      }
    }

    throw new \Exception("$value for radio button $element not found.");
  }

  /**
   * Sets an id for the first iframe situated in the element specified by id.
   * Needed when wanting to fill in WYSIWYG editor situated in an iframe
   * without identifier. See
   * https://www.drupal.org/node/1826016#comment-7753999.
   *
   * @Given /^the iframe in element "(?P<element>[^"]*)" has id "(?P<id>[^"]*)"$/
   */
  public function theIframeInElementHasId($element_id, $iframe_id) {
    $function = <<<JS
(function(){
  var elem = document.getElementById("$element_id");
  var iframes = elem.getElementsByTagName('iframe');
  var f = iframes[0];
  f.id = "$iframe_id";
})()
JS;
    try {
      $mink = $this->minkContext;
      $mink->getSession()->executeScript($function);
    }
    catch (Exception $e) {
      throw new \Exception(sprintf('No iframe found in the element "%s" on the page "%s".', $element_id, $mink->getSession()
                                                                                                              ->getCurrentUrl()));
    }
  }

  /**
   * Fills in WYSIWYG editor with specified id.
   * See https://www.drupal.org/node/1826016#comment-7753963.
   *
   * @Given /^(?:|I )fill in "(?P<text>[^"]*)" in WYSIWYG editor "(?P<iframe>[^"]*)"$/
   */
  public function iFillInInWYSIWYGEditor($text, $iframe) {
    $mink = $this->minkContext;
    $session = $mink->getSession();

    try {
      $session->switchToIFrame($iframe);
    }
    catch (Exception $e) {
      throw new \Exception(sprintf("No iframe with id '%s' found on the page '%s'.", $iframe, $session->getCurrentUrl()));
    }
    $session->executeScript("document.body.innerHTML = '<p>" . $text . "</p>'");
    $session->switchToIFrame();
  }

  /**
   * @Then /^the response header "([^"]*)" should contain "([^"]*)"$/
   */
  public function theResponseHeaderShouldContain($arg1, $arg2) {
    $mink = $this->minkContext;
    $headers = $mink->getSession()->getResponseHeaders();
    if (!isset($headers[$arg1])) {
      throw new Exception('The HTTP header "' . $arg1 . '" does not appear to be set.');
    }
    if (!in_array($arg2, $headers[$arg1])) {
      throw new Exception('The HTTP header "' . $arg1 . '" did not contain "' . $arg2 . '"');
    }
  }

  /**
   * @Then /^the response header should not have "([^"]*)"$/
   */
  public function theResponseHeaderShouldNotHave($arg1) {
    $mink = $this->minkContext;
    $headers = $mink->getSession()->getResponseHeaders();

    if (isset($headers[$arg1])) {
      throw new Exception('The HTTP header "' . $arg1 . '" is set to: ' . array_pop($headers[$arg1]) . '.');
    }

  }

  /**
   * @Then the href in element :arg1 should contain :arg2
   */
  public function theHrefInElementShouldContain($element_id, $pattern) {
    $mink = $this->minkContext;
    $page = $mink->getSession()->getPage();
    $el = $page->find('css', '.btn');

    if ($el->hasAttribute('href')) {
      $attr = $el->getAttribute('href');
      if (!(strstr($attr, $pattern))) {
        throw new \Exception(sprintf('Text %s not found with element %s".', $pattern, $element_id));
      }
      echo $el->getAttribute('href');
    }
    else {
      throw new \Exception(sprintf('No %s element found".', $element_id));
    }
  }

  /**
   * @Given /^I fill in "([^"]*)" with$/
   */
  public function iFillInWith($field, PyStringNode $value) {
    $raw = $value->getRaw();
    $mink = $this->minkContext;

    $element = $mink->getSession()->getPage();
    $element->fillField($field, $raw);
  }

  /**
   * @Then I should see all timestamps for :arg1 in :arg2 order
   *
   * This assumes there's a string something like:
   * content="2017-08-28T00:00:00-07:00">
   * associated with the inner HTML of the given element
   */
  public function iShouldSeeAllTimestampsForInOrder($element, $direction) {
    $container = $this->getSession()->getPage();
    $nodes = $container->findAll('css', $element);
    $needle_end = '">';
    $needle_start = 'content="';
    $mink = $this->minkContext;
    $session = $mink->getSession();

    if (count($nodes) == 0) {
      $message = sprintf('%d "%s" elements found when there should be a minimum of 1.', count($nodes), $element);
      throw new ExpectationException($message, $session);
    }

    // Get the first timestamp.
    $prev_time = $this->getStringBetween($nodes[0]->getHTML(), $needle_start, $needle_end);

    foreach ($nodes as $node) {
      $cur_time = $this->getStringBetween($node->getHTML(), $needle_start, $needle_end);
      if ($direction == "descending") {
        if ($prev_time < $cur_time) {
          $message = sprintf('Timestamps are not in %s order. Previous timestamp: %s, Current timestamp: %s',
            $direction, $prev_time, $cur_time);
          throw new ExpectationException($message, $session);
        }
      }
      elseif ($direction == "ascending") {
        if ($prev_time >= $cur_time) {
          $message = sprintf('Timestamps are not in %s order. Previous timestamp: %s, Current timestamp: %s',
            $direction, $prev_time, $cur_time);
          throw new ExpectationException($message, $session);
        }
      }

      $prev_time = $cur_time;
    }
  }

  /**
   * @Then the :arg1 checkbox should be disabled
   */
  public function theCheckboxShouldBeDisabled($selector) {
    $session = $this->getSession();
    $element = $session->getPage()->find('named', array('checkbox', $selector));
    if (is_null($element)) {
      throw new \Exception(sprintf('"%s" checkbox not found".', $selector));
    }

    if ($element->hasAttribute('disabled')) {
      return TRUE;
    }

    throw new \Exception(sprintf('The "%s" checkbox is not disabled', $selector));
  }

  /**
   * @Given I am logged in as User One
   */
  public function iAmLoggedInAsUserOne() {
    // Check if logged in.
    if ($this->loggedIn()) {
      $this->logout();
    }
    $url = $this->getDriver()->drush('user-login 1 --browser=0');
    $this->visitPath($url);
  }

   /**
   * @Given I am logged out
   */
  public function iAmLoggedOut() {
    // Check if logged in.
    if ($this->loggedIn()) {
      $this->logout();
    }
  }


    /**
   * @Then I should see no duplicate HTML with :arg1
   */
  public function iShouldSeeNoDuplicateHtmlWith($arg1) {
    $mink = $this->minkContext;
    $session = $mink->getSession();
    $container = $this->getSession()->getPage();
    $nodes = $container->findAll('css', $arg1);

    // I would expect to see something if you're running this test.
    if (count($nodes) == 0) {
      $message = sprintf('%d "%s" elements found when there should be a minimum of 1.', count($nodes), $arg1);
      throw new ExpectationException($message, $session);
    }

    // Build the array.
    $check_array = array();
    foreach ($nodes as $node) {
      $html = $node->getHTML();
      $check_array[] = $html;
    }

    // Are all unique?
    if (count($check_array) != count(array_unique($check_array))) {
      $message = sprintf('Duplicate HTML with class "%s" found. With a total of %d, %d were unique.',
        $arg1, count($check_array), count(array_unique($check_array)));
      throw new ExpectationException($message, $session);
    }
  }
}
