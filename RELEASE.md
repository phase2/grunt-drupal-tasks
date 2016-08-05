# Releasing New Versions of Grunt Drupal Tasks

The following documents the standard process to release a new version of Grunt
Drupal Tasks:

- Update the `CHANGELOG.md` file.

    Use `git log v0.9.2...HEAD --oneline` to get a summary of commit messages
    since the latest release.

    Summarize changes and note any modifications needed to upgrade existing
    instances.

- Update the version in `package.json`.

    Decide whether the next release is a major, minor, or patch level according
    to the semver specification.

    If updating to a new major or minor version, then also update the version of
    Grunt Drupal Tasks required in `example/package.json`.

- Update `npm-shrinkwrap.json`.

    This is most important when dependencies have been updated, but since this
    file contains the version of Grunt Drupal Tasks, it should be updated as
    part of the release process.

    First, delete `npm-shrinkwrap.json` and `node_modules`. Then, run:
    `npm i --prod && npm shrinkwrap`.

    Installing with the `--prod` option excludes dev dependencies, which avoids
    an issue with npm v2 where modules that are dev dependencies are not
    included in the shrinkwrap file.

- Tag a new version.

    Once all updates are committed, tag a new version using `git tag -a v0.9.3
    -m "Version 0.9.3."` and push the tag.

- Run `npm publish` to publish the release to npm.

    For pre-releases (alpha, non-stable), specify a release tag by running:
    `npm publish --tag alpha`
