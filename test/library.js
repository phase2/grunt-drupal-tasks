var assert = require('assert');
var util = require('../lib/util');

describe('Utility Functions', function() {
  describe('provides a capability to determine effective concurrency', function() {
    it('should have "concurrency" to recommend a safe limit greater than 2', function() {
      var limit = util.concurrency;
      assert(limit >= 2, 'concurrency limit not >= 2');
    });
  });
  describe('provides a capability to construct absolute URLs', function() {
    it ('allows expansion of a root path', function() {
      var items = util.expandUrls('http://example.com', ['/']);
      assert.equal('http://example.com/', items[0]);
    });
    it ('allows expansion of multiple paths', function() {
      var items = util.expandUrls('http://example.com', ['/a', '/b']);
      assert.equal('http://example.com/a', items[0]);
      assert.equal('http://example.com/b', items[1]);
    });
    it ('allows expansion of a base URL with a base path', function() {
      var items = util.expandUrls('http://example.com/subsite', ['/a', '/b']);
      assert.equal('http://example.com/subsite/a', items[0]);
      assert.equal('http://example.com/subsite/b', items[1]);
    });
  });
});
