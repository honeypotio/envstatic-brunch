warn = (message) -> EnvStatic.logger.warn "env-static-brunch WARNING: #{message}"

class EnvStatic
  brunchPlugin: true

  constructor: (@config) ->
    # Defaults options
    @options = {
      # A RegExp where the first subgroup matches the token to be replaced
      pattern: /\$ENV_STATIC(\w+)/gi
    }

    # Merge config
    cfg = @config.plugins?.digest ? {}
    @options[k] = cfg[k] for k of cfg

    # Ensure that the pattern RegExp is global
    needle = @options.pattern.source or @options.pattern or ''
    flags = 'g'
    flags += 'i' if @options.pattern.ignoreCase
    flags += 'm' if @options.pattern.multiline
    @options.pattern = new RegExp(needle, flags)

  onCompile: ->
    @publicFolder = @config.paths.public
    warn 'Oh... something is happening'

EnvStatic.logger = console

module.exports = EnvStatic
