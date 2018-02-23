<?php

namespace Drupal\Tests\gdt_test\Unit;

use Drupal\Tests\UnitTestCase;

/**
 * A PHPUnit test to ensure that the `grunt test:drupal` command is working.
 *
 * @group gdt_test
 */
class PassTest extends UnitTestCase {

  /**
   * Passing test.
   */
  public function testPassing() {
    $this->assertTrue(TRUE, 'True is true');
  }

}
