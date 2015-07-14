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

    // Ensure the build/html/sites/all/themes/custom/example_theme/stylesheets/screen.css
    // file exists, which should be created by compass.
    var sassDest = (drupalCore == '8') ? 'build/html/themes/custom/example_theme/stylesheets/screen.css' : 'build/html/sites/all/themes/custom/example_theme/stylesheets/screen.css';
    it('it should compile sass files', function(done) {
      fs.exists(sassDest, function (exists) {
        assert.ok(exists);
        done();
      });
    });
  });

  describe('themes configuration', function() {
    it('should run theme scripts', function(done) {
      exec('grunt themes:example_theme:write', function (error, stdout, stderr) {
        var status = !error && stdout && stdout.match(/scripts\srun/)[0];
        assert.ok(status);
        done();
      });
    });
  });

});
