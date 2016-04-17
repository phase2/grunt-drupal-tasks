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

    // Ensure a custom library file is available under build.
    var librariesBuildDest = (drupalCore == '8') ? 'build/html/libraries/example_lib/example.md' : 'build/html/sites/all/libraries/example_lib/example.md';
    it('custom library file should exist in build', function(done) {
      fs.exists(librariesBuildDest, function (exists) {
        assert.ok(exists);
        done();
      });
    });

    // Ensure a custom module file is available under build.
    var modulesBuildDest = (drupalCore == '8') ? 'build/html/modules/custom/test.php' : 'build/html/sites/all/modules/custom/test.php';
    it('custom module file should exist in build', function(done) {
      fs.exists(modulesBuildDest, function (exists) {
        assert.ok(exists);
        done();
      });
    });

    // Ensure a custom theme file is available under build.
    var themesBuildDest = (drupalCore == '8') ? 'build/html/themes/custom/example_theme/config.rb' : 'build/html/sites/all/themes/custom/example_theme/config.rb';
    it('custom theme file should exist in build', function(done) {
      fs.exists(themesBuildDest, function (exists) {
        assert.ok(exists);
        done();
      });
    });

    // Ensure a custom library file is available under package.
    var librariesPackageDest = (drupalCore == '8') ? 'build/packages/package/libraries/example_lib/example.md' : 'build/packages/package/sites/all/libraries/example_lib/example.md';
    it('custom library file should exist in package', function(done) {
      fs.exists(librariesPackageDest, function (exists) {
        assert.ok(exists);
        done();
      });
    });

    // Ensure a custom module file is available under package.
    var modulesPackageDest = (drupalCore == '8') ? 'build/packages/package/modules/custom/test.php' : 'build/packages/package/sites/all/modules/custom/test.php';
    it('custom module file should exist in package', function(done) {
      fs.exists(modulesPackageDest, function (exists) {
        assert.ok(exists);
        done();
      });
    });

    // Ensure a custom theme file is available under package.
    var themesPackageDest = (drupalCore == '8') ? 'build/packages/package/themes/custom/example_theme/config.rb' : 'build/packages/package/sites/all/themes/custom/example_theme/config.rb';
    it('custom theme file should exist in package', function(done) {
      fs.exists(themesPackageDest, function (exists) {
        assert.ok(exists);
        done();
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
