# Continuous Integration

One of the key advantages of the `grunt-drupal-tasks` system is the ability to
easily roll a broad suite of generalizable tests into your CI process. In order
to integrate with your CI system, there is often small snippets of code to be
written.

## Jenkins

In order to best leverage Jenkins for your CI process, you will want to use
the grunt tools for their full range of testing.

```bash
trap 'exit' ERR
cd /opt/development/example.com
git fetch origin
git rebase origin/develop
npm install
grunt
# ::Your installation script here.
grunt test
```

### Reports

In addition to the core CI routine, you may configure Jenkins to run the `analyze`
task to collect reports on build behavior. Properly configured, you will get charts
and the ability to inspect error messages within the Jenkins UI.

```bash
grunt analyze

if [ -f "build/reports/phpmd.xml" ]; then
  cp build/reports/phpmd.xml $WORKSPACE
fi

if [ -f "build/reports/phpcs.xml" ]; then
  cp build/reports/phpcs.xml $WORKSPACE
fi
```

### Configure PHPCS

* If you have not yet, install the [Checkstyle Plugin](https://wiki.jenkins-ci.org/display/JENKINS/Checkstyle+Plugin)
* In **Post-build Actions** add "Publish Checkstyle analysis results"
* Configure the results to be phpcs.xml

### Configure PHPMD

* If you have not yet, install the [PMD Plugin](https://wiki.jenkins-ci.org/display/JENKINS/PMD+Plugin)
* In **Post-build Actions** add "Publish PHPMD analysis results"
* Configure the results to be phpmd.xml
