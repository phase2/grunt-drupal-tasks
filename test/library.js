var assert = require('assert');
var GDT = require('../lib/util') ;

describe('grunt-drupal-tasks/util.js', function() {
  describe('provides a capability to construct absolute URLs', function() {
    it ('allows expansion of a root path', function() {
      var items = GDT.expandUrls('http://example.com', ['/']);
      assert.equal('http://example.com/', items[0]);
    });
    it ('allows expansion of multiple paths', function() {
      var items = GDT.expandUrls('http://example.com', ['/a', '/b']);
      assert.equal('http://example.com/a', items[0]);
      assert.equal('http://example.com/b', items[1]);
    });
    it ('allows expansion of a base URL with a base path', function() {
      var items = GDT.expandUrls('http://example.com/subsite', ['/a', '/b']);
      assert.equal('http://example.com/subsite/a', items[0]);
      assert.equal('http://example.com/subsite/b', items[1]);
    });
  })
})
