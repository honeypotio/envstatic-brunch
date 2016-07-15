Envstatic = require('../src/index')
expect = require('chai').expect
fs = require 'fs'
fse = require 'fs-extra'
path = require 'path'

Envstatic.logger = {
  warn: (message) -> null # do nothing
}

readFile = (filename) ->
  filepath = path.join(__dirname, 'public', filename)
  fs.readFileSync(filepath, 'UTF-8')


setupFakeFileSystem = ->
  fse.removeSync path.join(__dirname, 'public')
  fse.copySync path.join(__dirname, 'fixtures'), path.join(__dirname, 'public')

describe 'Envstatic', ->
  envstatic = null

  beforeEach ->
    envstatic = new Envstatic(
      env: ['production']
      paths:
        public: path.join('test', 'public')
      plugins:
        envstatic:
          referenceFiles: /\.js$/
          variables:
            APP_HOST: 'app.example.com'
    )

  after ->
    fse.removeSync path.join(__dirname, 'public')

  it 'is an instance of Envstatic', ->
    expect(envstatic).to.be.instanceOf(Envstatic)

  describe 'on compile', ->
    beforeEach ->
      setupFakeFileSystem()
      envstatic.onCompile()

    it 'removes matched patterns', ->
      contents = readFile('app.js')
      expect(contents).to.not.contain('ENVSTATIC_APP_HOST')

    it 'replaces with variable from options', ->
      contents = readFile('app.js')
      expect(contents).to.contain('app.example.com')
