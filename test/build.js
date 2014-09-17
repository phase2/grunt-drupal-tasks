var assert = require('assert');
var fs = require('fs');
var exec = require('child_process').exec;

describe('grunt', function() {
  describe('default', function() {

    // Ensure the build/html directory exists.
    it('it should create the build/html directory', function(done) {
      fs.exists('build/html', function (exists) {
        assert.ok(exists);
        done();
      });
    });

    // Ensure build/html/index.php exists and that index.php can be executed
    // with PHP.
    it('it should build a runnable Drupal docroot', function(done) {
      fs.exists('build/html/index.php', function (exists) {
        assert.ok(exists);

        if (exists) {
          process.chdir('build/html');
          exec('php index.php', function (error, stdout, stderr) {
            var testDrupalRan = (error === null);
            process.chdir('../..');
            assert.ok(testDrupalRan, "Drupal's index.php could be executed with PHP");
            done();
          });
        }
        else {
          done();
        }
      });
    });

    // Ensure the build/html/sites/all/modules/custom directory is a symlink to
    // ../../../../../src/modules.
    it('it should link the build/html/sites/all/modules/custom directory', function(done) {
      fs.lstat('build/html/sites/all/modules/custom', function (err, stats) {
        assert.ok(stats.isSymbolicLink());

        if (stats.isSymbolicLink()) {
          fs.readlink('build/html/sites/all/modules/custom', function (err, linkString) {
            assert.equal(linkString, '../../../../../src/modules');
            done();
          });
        }
        else {
          done();
        }
      });
    });

  });
});
