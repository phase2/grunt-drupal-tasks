# Testing

> Unit, Functional, Integration, and End-to-End test running.

## Configuration

**domain**: The domain of the site without protocol. It may also be a Base URL
(with a path prefix) so long as the protocol is excluded. This domain is used
to construct complete URLs for testing purposes. This may be overridden by the
`GDT_DOMAIN` environment variable, and if neither is set will fall back to the
environment's hostname. If a domain is specified, we recommend it is lined up
with any standard set for local development, as development processes should
not default to hitting a production or staging environment.

**siteUrls**: (Optional) A map of Drupal subsite names to the URLs by which
each can be accessed for end-to-end testing by tools such as Behat. For clarity
please align the site names (keys) with any Drush Site Aliases. If no siteUrls
are specified it will default to `http://<%= config.domain %>`. The environment
variable override is `GDT_SITEURLS`.

```
  "siteUrls": {
    "default": "http://<%= config.domain %>",
    "subsite": "http://sub.<%= config.domain %>.local",
    "external": "http://example.com"
  },
```

### Behat Settings

To support Behat tests, the example includes a basic **behat.yml** configuration
file and a **features/** directory for test cases inside the general **test/**
directory.

This is an example of the settings for Behat tasks:

```
{
  "behat": {
    "flags": "--tags '~@javascript'",
    "subsite": {
      "src": "./test/features/subsite/*.feature",
      "debug": false
    }
  }
}
```

**behat.\<siteurl\>**: A map of Drupal subsite names to a configuration object,
which will extend the defaults passed to
[grunt-parallel-behat](https://github.com/linusnorton/grunt-parallel-behat)

**behat.flags**: A string with any command-line arguments and options that
should be used while invoking Behat. These flags can be overridden by using the
`--behat-flags` option when running `grunt`. Common use cases are to include or
exclude tests according to tags or to use an alternative profile defined in
`behat.yml`.
