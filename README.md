envstatic-brunch
=============

A [Brunch][] plugin that replaces tokens with predefined variables.


Usage
-----

When you want to have a variable to be injected into your js files
durring build time.

`npm install --save-dev envstatic-brunch`

```javascript
// app.js
var app_host = $ENVSTATIC_APP_HOST;
```

```coffeescript
## brunch-config.coffee
exports.config =
  # ...
  plugins:
    envstatic:
      ## variables to be substitued
      variables:
        APP_HOST: process.env.APP_HOST
```

will replace the envstatic placeholedr with value configured in
your brunch-config file.

```javascript
// app.js
var app_host = 'app.example.com';
```

Options
-------

_Optional_ You can override envstatic-brunch's default options by updating your
`config.coffee` with overrides.

These are the default settings:

```coffeescript
exports.config =
  # ...
  plugins:
    envstatic:
      ## Placeholder prefix to be concatinated with variable names
      prefix: '$ENVSTATIC_'
      ## A RegExp where the first subgroup matches the token to be replaced
      pattern: /\$ENVSTATIC_(\w+)/gi
      ## RegExp that matches files that contain filename references.
      referenceFiles: /\.js$/
      ## variables to be substitued
      #variables:
      #  APP_HOST: 'app.example.com'
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
