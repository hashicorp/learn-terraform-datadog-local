terraform {
  required_providers {
    datadog = {
      source  = "datadog/datadog"
      version = "~> 2.24.0"
    }
    helm = {
      source  = "hashicorp/helm"
      version = "~> 2.0.3"
    }
    kubernetes = {
      source  = "hashicorp/kubernetes"
      version = "~> 2.0.3"
    }
    aws = {
      source  = "hashicorp/aws"
      version = "~> 3.34"
    }
  }
  required_version = "~> 0.13"
}

provider "aws" {
  region = "us-east-2"
}
