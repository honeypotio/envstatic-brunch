pathlib = require 'path'
glob = require 'glob'
fs = require 'fs'

class Envstatic
  brunchPlugin: true

  constructor: (@config) ->
    # Defaults options
    @options = {
      # Placeholder prefix to be concatinated with variable names
      prefix: '$ENVSTATIC_'
      # A RegExp where the first subgroup matches the token to be replaced
      pattern: /\$ENVSTATIC_(\w+)/gi
      # RegExp that matches files that contain filename references.
      referenceFiles: /\.js$/
      # variables to be substitued
      variables:
        APP_HOST: 'app.example.com'
    }

    # Merge config
    cfg = @config.plugins?.envstatic ? {}
    @options[k] = cfg[k] for k of cfg

    # Ensure that the pattern RegExp is global
    needle = @options.pattern.source or @options.pattern or ''
    flags = 'g'
    flags += 'i' if @options.pattern.ignoreCase
    flags += 'm' if @options.pattern.multiline
    @options.pattern = new RegExp(needle, flags)

  onCompile: ->
    @publicFolder = @config.paths.public
    filesToSearch = @_referenceFiles()
    for file in filesToSearch
      @_replaceFile(file)

  _replaceFile: (file) ->
    data = fs.readFileSync file, "utf8"
    result = data.replace @options.pattern, (match) =>
      match = match.replace @options.prefix, ''
      if match and @options.variables[match]
        replacement = "'" + @options.variables[match] + "'"
      else
        replacement = 'undefined'
      replacement

    fs.writeFileSync file, result

  _referenceFiles: ->
    allUrls = glob.sync('**', { cwd: @publicFolder })
    referenceFiles = []
    for url in allUrls
      file = @_fileFromUrl url
      referenceFiles.push file if @options.referenceFiles.test(file)
    referenceFiles

  _fileFromUrl: (url) ->
    dir = @publicFolder
    file = pathlib.join(dir, url)
    pathlib.normalize(file)

Envstatic.logger = console

module.exports = Envstatic
