# ==============================================================================
# AWS Deployment
# ==============================================================================

AWS := aws
CDK := cdk
SAM := sam
TF := terraform

# AWS CDK
aws-cdk-synth: ## Synthesize AWS CDK stack
	cd infra/aws/cdk && $(CDK) synth

aws-cdk-deploy: ## Deploy AWS CDK stack
	cd infra/aws/cdk && $(CDK) deploy --require-approval never

aws-cdk-destroy: ## Destroy AWS CDK stack
	cd infra/aws/cdk && $(CDK) destroy --force

aws-cdk-diff: ## Show CDK stack diff
	cd infra/aws/cdk && $(CDK) diff

aws-cdk-bootstrap: ## Bootstrap CDK (first time setup)
	$(CDK) bootstrap

# CloudFormation
aws-cfn-deploy: ## Deploy CloudFormation stack (usage: make aws-cfn-deploy ENV=production)
	$(AWS) cloudformation deploy \
		--template-file infra/aws/cloudformation/template.yaml \
		--stack-name monorepo-api-$(ENV) \
		--parameter-overrides Environment=$(ENV) \
		--capabilities CAPABILITY_IAM

aws-cfn-delete: ## Delete CloudFormation stack
	$(AWS) cloudformation delete-stack --stack-name monorepo-api-$(ENV)

aws-cfn-describe: ## Describe CloudFormation stack
	$(AWS) cloudformation describe-stacks --stack-name monorepo-api-$(ENV)

aws-cfn-events: ## View CloudFormation stack events
	$(AWS) cloudformation describe-stack-events --stack-name monorepo-api-$(ENV)

# Terraform
aws-tf-init: ## Initialize AWS Terraform
	cd infra/aws/terraform && $(TF) init

aws-tf-plan: ## Plan AWS Terraform changes
	cd infra/aws/terraform && $(TF) plan

aws-tf-apply: ## Apply AWS Terraform changes
	cd infra/aws/terraform && $(TF) apply -auto-approve

aws-tf-destroy: ## Destroy AWS Terraform resources
	cd infra/aws/terraform && $(TF) destroy -auto-approve

aws-tf-output: ## Show Terraform outputs
	cd infra/aws/terraform && $(TF) output

# Lambda
aws-lambda-package: ## Package Lambda function
	cd apps/api && zip -r ../../lambda.zip src -x "*.pyc" -x "__pycache__/*"

aws-lambda-deploy: ## Deploy Lambda function
	$(AWS) lambda update-function-code \
		--function-name monorepo-api \
		--zip-file fileb://lambda.zip

aws-lambda-invoke: ## Invoke Lambda function
	$(AWS) lambda invoke \
		--function-name monorepo-api \
		--payload '{"path": "/health"}' \
		response.json && cat response.json

aws-lambda-logs: ## View Lambda logs
	$(AWS) logs tail /aws/lambda/monorepo-api --follow

# SAM (Serverless Application Model)
aws-sam-build: ## Build SAM application
	cd infra/aws/lambda && $(SAM) build

aws-sam-deploy: ## Deploy SAM application
	cd infra/aws/lambda && $(SAM) deploy --guided

aws-sam-local: ## Run SAM local API
	cd infra/aws/lambda && $(SAM) local start-api

# ECR (Elastic Container Registry)
aws-ecr-login: ## Login to ECR
	$(AWS) ecr get-login-password --region $(AWS_REGION) | docker login --username AWS --password-stdin $(AWS_ACCOUNT).dkr.ecr.$(AWS_REGION).amazonaws.com

aws-ecr-create: ## Create ECR repository
	$(AWS) ecr create-repository --repository-name monorepo-api

aws-ecr-push: ## Build and push to ECR
	docker build -t monorepo-api -f infra/docker/Dockerfile .
	docker tag monorepo-api:latest $(AWS_ACCOUNT).dkr.ecr.$(AWS_REGION).amazonaws.com/monorepo-api:latest
	docker push $(AWS_ACCOUNT).dkr.ecr.$(AWS_REGION).amazonaws.com/monorepo-api:latest

# ECS (Elastic Container Service)
aws-ecs-deploy: ## Deploy to ECS
	$(AWS) ecs update-service --cluster monorepo --service api --force-new-deployment

aws-ecs-logs: ## View ECS task logs
	$(AWS) ecs describe-tasks --cluster monorepo --tasks $(TASK_ARN)

# Utilities
aws-whoami: ## Show current AWS identity
	$(AWS) sts get-caller-identity

aws-regions: ## List AWS regions
	$(AWS) ec2 describe-regions --query "Regions[].RegionName" --output table

aws-costs: ## View current month costs
	$(AWS) ce get-cost-and-usage \
		--time-period Start=$$(date -v-30d +%Y-%m-%d),End=$$(date +%Y-%m-%d) \
		--granularity MONTHLY \
		--metrics "BlendedCost"

