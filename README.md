# hubot-gh-token

Stores GitHub Personal Access Tokens in Hubot's brain

See [`src/gh-token.coffee`](src/gh-token.coffee) for full documentation.

## Installation

In hubot project repo, run:

`npm install hubot-gh-token --save`

Then add **hubot-gh-token** to your `external-scripts.json`:

```json
["hubot-gh-token"]
```

## Configuration

  * `HUBOT_GITHUB_TOKEN_FERNET_SECRETS` - The key used for encrypting your tokens in the hubot's brain. A comma delimited set of different key tokens. To create one run dd if=/dev/urandom bs=32 count=1 2>/dev/null | openssl base64 on a UNIX system.

## Notes

Most of this code was extracted from 
[hubot-deploy](https://github.com/atmos/hubot-deploy) which uses code
from [hubot-vault](https://github.com/ys/hubot-vault)

This script is similar to
[hubot-github-identity](https://github.com/tombell/hubot-github-identity) but
allows users to set their tokens in chat instead of through Hubot's http
listener.

## Sample Interaction

```
user1>> bot github token set c0f6f12f70357a9aecc4ea5c30e7ba8e
bot>> Your GitHub token is valid. I stored it for future use.
user1>> bot github token verify
bot>> Your GitHub token is valid on api.github.com.
user1>> bot github token reset
bot>> I nuked your GitHub token. I'll try to use my default token until you configure another.
```
