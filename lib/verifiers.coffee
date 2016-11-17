Path         = require "path"
Octonode     = require "octonode"
GitHubApi    = require(Path.join(__dirname, "github", "api")).Api

VaultKey = "hubot-deploy-github-secret"

class ApiTokenVerifier
  constructor: (token) ->
    @token = token?.trim()

    @config = new GitHubApi(@token, null)

    hostname = @config.hostname
    path = @config.path()

    if path isnt "/"
      hostname += path

    @api = Octonode.client(@config.token, {hostname: hostname})

  valid: (cb) ->
    @api.get "/user", (err, status, data, headers) ->
      scopes = headers?['x-oauth-scopes']
      if scopes?.indexOf('repo') >= 0
        cb(true)
      else
        cb(false)

exports.VaultKey = VaultKey
exports.ApiTokenVerifier = ApiTokenVerifier
