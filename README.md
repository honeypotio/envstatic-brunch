env-static-brunch
=============

A [Brunch][] plugin that replaces tokens with predefined variables.


Usage
-----

`npm install --save-dev env-static-brunch`

Options
-------

_Optional_ You can override env-static-brunch's default options by updating your
`config.coffee` with overrides.

These are the default settings:

```coffeescript
exports.config =
  # ...
  plugins:
    env-static:
      # A RegExp where the first subgroup matches the token to be replaced
      pattern: /\$ENV_STATIC_(\w+)/gi
```

Contributing
------------

1. Add some tests
1. Add some code
1. Run `npm test`
1. Send a pull request

License
-------

MIT

[Brunch]: http://brunch.io
