Path = require 'path'
Vault = require('./lib/vault.coffee').Vault

VaultKey = require('./lib/verifiers.coffee').VaultKey

module.exports = (robot, scripts) ->
  robot.vault =
    forUser: (user) ->
      new Vault(user)

    key: VaultKey

  robot.loadFile(Path.resolve(__dirname, 'src'), 'gh-token.coffee')
