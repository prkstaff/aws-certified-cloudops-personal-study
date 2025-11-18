#!/bin/bash

CURRENT_DIR=$(pwd)
SHARED_DIR="$(dirname "$(pwd)")/shared"
AULA_NAME=$(basename "$CURRENT_DIR")

if [[ ! "$CURRENT_DIR" =~ /study/ ]]; then
  echo "Erro: rode o 'tf_init.sh' só dentro de uma pasta de aula em terraform/study/"
  exit 1
fi

# S3 Backend Configuration
S3_BUCKET="aws-cloudops-study-terraform-state"
DYNAMODB_TABLE="aws-cloudops-study-terraform-locks"
STATE_KEY="study/${AULA_NAME}/terraform.tfstate"

# Generate backend.tf
echo "Generating backend.tf for: $AULA_NAME"
cat > backend.tf <<EOF
terraform {
  backend "s3" {
    bucket         = "${S3_BUCKET}"
    key            = "${STATE_KEY}"
    region         = "us-east-1"
    dynamodb_table = "${DYNAMODB_TABLE}"
    encrypt        = true
  }
}
EOF

# Generate provider.tf
echo "Generating provider.tf for: $AULA_NAME"
cat > provider.tf <<EOF
terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 6.0"
    }
  }
}

provider "aws" {
  region = "us-east-1"
  default_tags {
    tags = {
      Project     = "cloudops certification study"
      ManagedBy   = "terraform"
      study       = "${AULA_NAME}"
    }
  }
}
EOF

echo "Initializing Terraform for: $AULA_NAME"
echo "State will be stored at: s3://${S3_BUCKET}/${STATE_KEY}"

terraform init \
  -reconfigure \
  -backend-config="bucket=${S3_BUCKET}" \
  -backend-config="key=${STATE_KEY}" \
  -backend-config="region=us-east-1" \
  -backend-config="dynamodb_table=${DYNAMODB_TABLE}" \
  -backend-config="encrypt=true"
