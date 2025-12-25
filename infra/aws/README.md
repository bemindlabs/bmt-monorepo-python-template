# AWS Infrastructure

AWS deployment configuration for Python applications using CDK, CloudFormation, and Terraform.

## Structure

```
aws/
├── cdk/                # AWS CDK Python stack
│   ├── app.py
│   ├── cdk.json
│   └── stacks/
├── cloudformation/     # CloudFormation templates
│   ├── template.yaml
│   └── parameters/
├── terraform/          # Terraform configurations
│   ├── main.tf
│   ├── variables.tf
│   └── outputs.tf
├── lambda/             # Lambda function configs
│   └── template.yaml
└── README.md
```

## Prerequisites

- AWS CLI configured with credentials
- AWS CDK installed (for CDK deployments)
- Terraform installed (for Terraform deployments)

## Setup

### AWS CLI

```bash
# Install AWS CLI
pip install awscli

# Configure credentials
aws configure

# Verify
aws sts get-caller-identity
```

### AWS CDK

```bash
# Install CDK
npm install -g aws-cdk

# Bootstrap (first time only)
cdk bootstrap aws://ACCOUNT-ID/REGION
```

### Terraform

```bash
# Install Terraform
brew install terraform

# Initialize
cd infra/aws/terraform
terraform init
```

## CDK Deployment

### Stack Structure

```python
# infra/aws/cdk/stacks/api_stack.py
from aws_cdk import (
    Stack,
    aws_lambda as _lambda,
    aws_apigateway as apigw,
    Duration,
)
from constructs import Construct

class ApiStack(Stack):
    def __init__(self, scope: Construct, id: str, **kwargs):
        super().__init__(scope, id, **kwargs)

        # Lambda function
        api_lambda = _lambda.Function(
            self, "ApiHandler",
            runtime=_lambda.Runtime.PYTHON_3_12,
            code=_lambda.Code.from_asset("../../apps/api"),
            handler="src.api.main.handler",
            timeout=Duration.seconds(30),
            memory_size=1024,
        )

        # API Gateway
        api = apigw.LambdaRestApi(
            self, "ApiGateway",
            handler=api_lambda,
        )
```

### Deploy

```bash
# Synth (preview)
make aws-cdk-synth

# Deploy
make aws-cdk-deploy

# Destroy
make aws-cdk-destroy
```

## CloudFormation

### Template

```yaml
# infra/aws/cloudformation/template.yaml
AWSTemplateFormatVersion: '2010-09-09'
Description: Python Monorepo API Stack

Parameters:
  Environment:
    Type: String
    AllowedValues: [development, staging, production]

Resources:
  ApiFunction:
    Type: AWS::Lambda::Function
    Properties:
      Runtime: python3.12
      Handler: src.api.main.handler
      MemorySize: 1024
      Timeout: 30
```

### Deploy

```bash
# Deploy stack
make aws-cfn-deploy ENV=production

# Delete stack
make aws-cfn-delete
```

## Terraform

### Configuration

```hcl
# infra/aws/terraform/main.tf
terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }

  backend "s3" {
    bucket = "terraform-state-bucket"
    key    = "monorepo/terraform.tfstate"
    region = "ap-southeast-1"
  }
}

provider "aws" {
  region = var.region
}

module "api" {
  source = "./modules/api"

  environment = var.environment
  memory_size = var.memory_size
}
```

### Deploy

```bash
# Plan
make aws-tf-plan

# Apply
make aws-tf-apply

# Destroy
make aws-tf-destroy
```

## Lambda Deployment

### Using SAM

```bash
# Install SAM CLI
pip install aws-sam-cli

# Build
sam build

# Deploy
sam deploy --guided
```

### Direct Upload

```bash
# Package
make aws-lambda-package

# Deploy
make aws-lambda-deploy
```

## Environment Variables

Set in AWS Console, SSM Parameter Store, or Secrets Manager:

| Variable | Description | Storage |
|----------|-------------|---------|
| `ENVIRONMENT` | production/staging | Lambda env |
| `LOG_LEVEL` | INFO/WARNING | Lambda env |
| `SECRET_KEY` | Application secret | Secrets Manager |
| `DATABASE_URL` | Database connection | SSM Parameter |

## Regions

Recommended regions:
- `ap-southeast-1` - Singapore
- `ap-northeast-1` - Tokyo
- `us-east-1` - N. Virginia
- `eu-west-1` - Ireland

## Makefile Targets

```bash
# CDK
make aws-cdk-synth      # Synthesize CDK stack
make aws-cdk-deploy     # Deploy CDK stack
make aws-cdk-destroy    # Destroy CDK stack
make aws-cdk-diff       # Show diff

# CloudFormation
make aws-cfn-deploy     # Deploy CloudFormation stack
make aws-cfn-delete     # Delete CloudFormation stack

# Terraform
make aws-tf-init        # Initialize Terraform
make aws-tf-plan        # Plan Terraform changes
make aws-tf-apply       # Apply Terraform changes
make aws-tf-destroy     # Destroy Terraform resources

# Lambda
make aws-lambda-package # Package Lambda function
make aws-lambda-deploy  # Deploy Lambda function
```

## Cost Optimization

- Use Lambda with appropriate memory sizing
- Enable Lambda Provisioned Concurrency for production
- Use S3 Intelligent-Tiering for storage
- Set up AWS Budgets alerts

## Security Best Practices

- Use IAM roles with least privilege
- Enable VPC for Lambda (if accessing RDS)
- Use Secrets Manager for sensitive data
- Enable CloudTrail for auditing
- Use AWS WAF for API Gateway

## Troubleshooting

### Lambda Issues

```bash
# View logs
aws logs tail /aws/lambda/function-name --follow

# Invoke test
aws lambda invoke --function-name api-handler output.json
```

### Permission Issues

```bash
# Check current identity
aws sts get-caller-identity

# Assume role
aws sts assume-role --role-arn arn:aws:iam::ACCOUNT:role/ROLE
```
