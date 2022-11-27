#!/bin/bash
set -ex

for i in ./_terraform/terraform.tfvars ; do \
sed -E "s|\{ECR_NAME\}|${ecr_name}|g" -i ${i}; \
sed -E "s|\{REGION\}|${region}|g" -i ${i}; \
sed -E "s|\{IMAGE_TAG\}|${image_tag}|g" -i ${i}; \
sed -E "s|\{LAMBDA_NAME\}|${lambda_name}|g" -i ${i}; \
sed -E "s|\{LAMBDA_DESCRIPTION\}|${lambda_description}|g" -i ${i}; done