chai = require 'chai'
sinon = require 'sinon'
chai.use require 'sinon-chai'

expect = chai.expect

describe 'gh-token', ->
  beforeEach ->
    @robot =
      respond: sinon.spy()
      hear: sinon.spy()

    require('../src/gh-token')(@robot)

  it 'registers a respond listener for "github token set <token>"', ->
    expect(@robot.respond).to.have.been.calledWith(/(github|gh) token set ([0-9a-f]+)$/i)

  it 'registers a respond listener for "github token reset"', ->
    expect(@robot.respond).to.have.been.calledWith(/(github|gh) token reset$/i)

  it 'registers a respond listener for "github token verify"', ->
    expect(@robot.respond).to.have.been.calledWith(/(github|gh) token verify$/i)
