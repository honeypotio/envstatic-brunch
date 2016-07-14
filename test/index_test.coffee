EnvStatic = require('../src/index')
expect = require('chai').expect
fs = require 'fs'
fse = require 'fs-extra'
path = require 'path'

EnvStatic.logger = {
  warn: (message) -> null # do nothing
}

describe 'EnvStatic', ->
  envStatic = null

  beforeEach ->
    envStatic = new EnvStatic(
      env: ['production']
      paths:
        public: path.join('test', 'public')
      plugins:
        'env-static':
          referenceFiles: /\.(js)$/
          variables:
            GA_ID: 'GA123423'
    )

  after ->
    fse.removeSync path.join(__dirname, 'public')

  it 'is an instance of EnvStatic', ->
    expect(envStatic).to.be.instanceOf(EnvStatic)
