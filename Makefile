ENVIRONMENT        ?= dev
PROJECT             = $(shell node -p 'require("./package.json").name')
AWS_DEFAULT_REGION ?= eu-west-1
BRANCH_NAME = "$(shell git branch | grep \* | cut -d ' ' -f2- | sed -E -e 's/\(|\)//g')"
COMMIT_HASH = $(shell git log -1 --format=%h)
TAGS = Environment=$(ENVIRONMENT) Project=$(PROJECT) GitBranch=$(BRANCH_NAME) GitCommit=$(COMMIT_HASH)
STACK_NAME = $(PROJECT)-$(ENVIRONMENT)

# You probably want to change these
ARTIFACTS_BUCKET = irish-luck
DOMAIN ?= localhost

package = aws cloudformation package \
    --template-file cloudformation.yaml \
    --output-template-file dist/cloudformation.dist.yaml \
    --s3-bucket $(ARTIFACTS_BUCKET) \
    --s3-prefix $(STACK_NAME)

deploy = aws cloudformation deploy --template-file dist/cloudformation.dist.yaml \
    --stack-name $(STACK_NAME) \
    --region $(AWS_DEFAULT_REGION) \
    --tags $(TAGS) \
    --parameter-overrides \
      PROJECT=$(PROJECT) \
      ENVIRONMENT=$(ENVIRONMENT) \
      DOMAIN=$(DOMAIN) \
    --capabilities CAPABILITY_IAM CAPABILITY_NAMED_IAM \
    --s3-bucket $(ARTIFACTS_BUCKET)

deploy:
	@echo "Resetting dist directory"
	@rm -rf dist
	@mkdir -p dist

	@echo "Building deployment package"
	@cp -r src dist/
	@cp package.json dist/src/package.json
	@cd dist/src/ && npm install --production

	@echo "Deploying"
	$(call package)
	$(call deploy)

	@echo "Cleaning up"
	@rm -rf dist
	@echo "Done!"
