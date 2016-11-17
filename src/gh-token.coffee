# Description:
#   Stores GitHub Personal Access Tokens in Hubot's brain
#
# Configuration:
#   HUBOT_GITHUB_TOKEN_FERNET_SECRETS - The key used for encrypting your tokens in the hubot's brain. See README for details.
#
# Commands:
#   hubot github token set <github_personal_access_token> - Set your user's GitHub token (USE THIS ONLY IN A PRIVATE CHAT WITH THE BOT)
#   hubot github token reset - Resets (forgets) your user's GitHub token
#   hubot github token verify - Verifies your GitHub token is valid and has the appropriate scope(s)
#

Path = require("path")

Verifiers = require(Path.join(__dirname, "..", "lib", "verifiers"))

TokenForBrain = Verifiers.VaultKey
ApiTokenVerifier = Verifiers.ApiTokenVerifier

module.exports = (robot) ->
  robot.respond /(github|gh) token set ([0-9a-f]+)$/i, id: 'gh-token.set', (msg) ->
    user = robot.brain.userForId msg.envelope.user.id
    token = msg.match[2]

    verifier = new ApiTokenVerifier token
    verifier.valid (result) ->
      if result
        robot.vault.forUser(user).set(TokenForBrain, verifier.token)
        msg.send "Your GitHub token is valid. I stored it for future use."
      else
        msg.send "Your GitHub token is invalid, verify that it has 'repo' scope."

  robot.respond /(github|gh) token reset$/i, id: 'gh-token.reset', (msg) ->
    user = robot.brain.userForId msg.envelope.user.id
    robot.vault.forUser(user).unset(TokenForBrain)
    msg.reply "I nuked your GitHub token. I'll try to use my default token until you configure another."

  robot.respond /(github|gh) token verify$/i, id: 'gh-token.verify', (msg) ->
    user = robot.brain.userForId msg.envelope.user.id
    token = robot.vault.forUser(user).get(TokenForBrain)
    verifier = new ApiTokenVerifier(token)
    verifier.valid (result) ->
      if result
        msg.send "Your GitHub token is valid on #{verifier.config.hostname}."
      else
        msg.send "Your GitHub token is invalid, verify that it has 'repo' scope."
