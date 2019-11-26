# aws-lambda-node-version

A Lambda for returning the currently deployed version of NodeJS in the *.x runtimes.

AWS continually updates their `nodejs10.x` and `nodejs12.x` runtimes but do not keep a record or announce their rollouts, and [sometimes](https://i.imgur.com/HrkrP0e.png) they are outright wrong in their documentation.

This makes it hard to provide an accurately up-to-date Docker image for development. This lambda is meant to help the [sleavely/node-awscli Docker image](https://hub.docker.com/r/sleavely/node-awscli) provide an environment that reflects reality, for continuous integration and deployment purposes.

## Deploying

```shell
ARTIFACTS_BUCKET=my-bucket DOMAIN=example.com make deploy
```
