# aws-lambda-node10-version

A Lambda for returning the currently deployed version of NodeJS in the 10.x runtime.

AWS continually updates it but do not keep a record or announce their rollouts, making it hard to provide an accurately up-to-date Docker image. This lambda is meant to help the [sleavely/node-awscli Docker image](https://hub.docker.com/r/sleavely/node-awscli) provide an environment that reflects reality, for continuous integration and deployment purposes.

## Deploying

```shell
ARTIFACTS_BUCKET=my-bucket DOMAIN=example.com make deploy
```
