vows   = require 'vows'
assert = require 'assert'

vows
  .describe('sample test')
  .addBatch
    'one':
      topic: -> 1
      'should equal one': (topic) ->
        assert.equal topic, 1
  .export(module)
