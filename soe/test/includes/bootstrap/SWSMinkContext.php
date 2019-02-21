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

use Drupal\DrupalExtension\Context\RawDrupalContext,
  // Drupal\DrupalExtension\Context\DrupalContext,
  Drupal\DrupalExtension\Context\MinkContext;

use SWSDrupalContext as DrupalContext;

/**
 * Features context.
 */
class SWSMinkContext extends MinkContext implements Context, SnippetAcceptingContext {

  /**
   * @var \Drupal\DrupalExtension\Context\DrupalContext
   */
  protected $drupalContext;

  /**
   * @BeforeScenario
   */
  public function gatherContexts(BeforeScenarioScope $scope) {
    $environment = $scope->getEnvironment();
    $this->drupalContext = $environment->getContext('SWSDrupalContext');
  }

  /**
   * Override MinkContext::fixStepArgument().
   *
   * Make it possible to use [random].
   * If you want to use the previous random value [random:1].
   * See
   * http://cgit.drupalcode.org/panopoly/tree/tests/behat/features/bootstrap/FeatureContext.php?id=18a2ccbdad8c8064aa36f8c57ae7416ee018b92f
   */
  protected function fixStepArgument($argument) {
    $argument = str_replace('\\"', '"', $argument);

    // Token replace the argument.
    static $random = array();
    for ($start = 0; ($start = strpos($argument, '[', $start)) !== FALSE;) {
      $end = strpos($argument, ']', $start);
      if ($end === FALSE) {
        break;
      }
      $name = substr($argument, $start + 1, $end - $start - 1);
      if ($name == 'random') {
        $randomObj = new Drupal\Component\Utility\Random();
        $randomname = $randomObj->name(8);
        $randomname = strtolower($randomname);
        $this->vars[$name] = $randomname;
        $random[] = $this->vars[$name];
      }
      // In order to test previous random values stored in the form,
      // suppport random:n, where n is the number or random's ago
      // to use, i.e., random:1 is the previous random value.
      elseif (substr($name, 0, 7) == 'random:') {
        $num = substr($name, 7);
        if (is_numeric($num) && $num <= count($random)) {
          $this->vars[$name] = $random[count($random) - $num];
        }
      }
      if (isset($this->vars[$name])) {
        $argument = substr_replace($argument, $this->vars[$name], $start, $end - $start + 1);
        $start += strlen($this->vars[$name]);
      }
      else {
        $start = $end + 1;
      }
    }

    return $argument;
  }

  /**
   * This works for the Goutte driver and I assume other HTML-only ones.
   *
   * @Then /^show me the HTML page$/
   */
  public function showMeHtmlPageInBrowser() {

    $html_data = $this->getSession()->getDriver()->getContent();
    $file_and_path = '/tmp/behat_page.html';
    file_put_contents($file_and_path, $html_data);

    if (PHP_OS === "Darwin" && PHP_SAPI === "cli") {
      exec('open -a "Safari.app" ' . $file_and_path);
    };
  }
}
