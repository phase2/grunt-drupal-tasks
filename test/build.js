var assert = require('assert');
var fs = require('fs');
var exec = require('child_process').exec;

describe('grunt', function() {

  describe('default', function() {
    var drupalCore = process.env['GDT_DRUPAL_CORE'];

    // Ensure the vendor directory exists.
    it('it should create the vendor directory', function(done) {
      fs.exists('vendor', function (exists) {
        assert.ok(exists);
        done();
      });
    });

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

    // Ensure there is a symlink to src/modules.
    var modulesSrc = (drupalCore == '8') ? '../../../src/modules' : '../../../../../src/modules',
      modulesDest = (drupalCore == '8') ? 'build/html/modules/custom' : 'build/html/sites/all/modules/custom';
    it('it should link the ' + modulesDest + ' directory', function(done) {
      fs.lstat(modulesDest, function (err, stats) {
        assert.ok(stats.isSymbolicLink());

        if (stats.isSymbolicLink()) {
          fs.readlink(modulesDest, function (err, linkString) {
            assert.equal(linkString, modulesSrc);
            done();
          });
        }
        else {
          done();
        }
      });
    });

    // Ensure there is a symlink for libs in src/libraries.
    var librariesSrc = (drupalCore == '8') ? '../../../src/libraries' : '../../../../../src/libraries',
      exampleLibSrc = librariesSrc + '/example_lib',
      librariesDest = (drupalCore == '8') ? 'build/html/libraries' : 'build/html/sites/all/libraries',
      exampleLibDest = librariesDest + '/example_lib';
    it('it should link libraries in the ' + librariesDest + ' directory', function(done) {
      fs.lstat(exampleLibDest, function (err, stats) {
        assert.ok(stats.isSymbolicLink());

        if (stats.isSymbolicLink()) {
          fs.readlink(exampleLibDest, function (err, linkString) {
            assert.equal(linkString, exampleLibSrc);
            done();
          });
        }
        else {
          done();
        }
      });
    });
  });

  describe('Script dispatching', function() {
    it('should pass commands along to themes', function(done) {
      exec('grunt themes:example_theme:echo', function (error, stdout, stderr) {
        var status = !error && stdout && stdout.match(/theme\sscripts\srun/)[0] && stdout.match(/run in example_theme/)[0];
        assert.ok(status);
        done();
      });
    });

    it('should run project operation scripts', function(done) {
      exec('grunt echo', function (error, stdout, stderr) {
        var status = !error && stdout && stdout.match(/operational\sscripts\srun/)[0];
        assert.ok(status);
        done();
      });
    });

    it('should run pre-op and post-op scripts', function(done) {
      exec('grunt echo', function (error, stdout, stderr) {
        var status = !error && stdout && stdout.match(/pre\-op script/)[0] && stdout.match(/post\-op script/)[0];
        assert.ok(status);
        done();
      });
    });

    it('should include project operation scripts in help output', function(done) {
      exec('grunt help', function (error, stdout, stderr) {
        var status = !error && stdout && stdout.match(/Perform\sthe\sconfigured\s"echo"\stask/)[0];
        assert.ok(status);
        done();
      });
    });
  });

  describe('grunt task', function() {
    it('"git-setup" may be run to install git hooks.', function(done) {
      exec('grunt git-setup', function(error, stdout, stderr) {
        fs.exists('./.git/hooks/pre-commit', function(exists) {
          assert.ok(!error && exists);
          done();
        });
      });
    });
  });
});
