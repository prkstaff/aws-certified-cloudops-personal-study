# Terraform Backend Infrastructure

This directory contains the Terraform configuration to set up the S3 backend infrastructure for your CloudOps study classes.

## What it creates

- **S3 Bucket**: Stores Terraform state files with versioning and encryption enabled
- **DynamoDB Table**: Provides state locking to prevent concurrent modifications

## Initial Setup

1. Initialize and apply this configuration first (before using it as a backend):

```bash
cd terraform/shared/backend
terraform init
terraform apply
```

2. Note the output values - these are used in your study class configurations

## Resources Created

- S3 Bucket: `aws-cloudops-study-terraform-state`
- DynamoDB Table: `aws-cloudops-study-terraform-locks`

## Security Features

- S3 versioning enabled (state file history)
- Server-side encryption (AES256)
- Public access blocked
- State locking via DynamoDB
