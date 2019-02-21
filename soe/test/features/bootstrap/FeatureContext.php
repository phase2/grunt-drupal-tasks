<?php

use Behat\Behat\Context\Context,
    Behat\Behat\Context\SnippetAcceptingContext,
    Behat\Behat\Context\ClosuredContextInterface,
    Behat\Behat\Context\TranslatedContextInterface,
    Behat\Behat\Context\BehatContext,
    Behat\Behat\Context\MinkContext,
    Behat\Behat\Context\TranslatableContext,
    Behat\Behat\Exception\PendingException,
    Behat\Mink\Exception\ExpectationException,
    Behat\Mink\Session;

use Behat\Gherkin\Node\PyStringNode,
    Behat\Gherkin\Node\TableNode;

use Drupal\Component\Utility\Random,
    Drupal\DrupalExtension\Context\DrupalContext;

/**
 * Defines application features from the specific context.
 */
class FeatureContext implements Context, SnippetAcceptingContext {
    /**
     * Initializes context.
     *
     * Every scenario gets its own context instance.
     * You can also pass arbitrary arguments to the
     * context constructor through behat.yml.
     */
    public function __construct() {

    }

}
