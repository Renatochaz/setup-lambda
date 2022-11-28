# Overview
Easilly deploy a containerized Lambda with ECR.

# Requirements
AWS CLI

Docker

Make

Terraform

# Usage
Configure the envfile arguments with the name of your applications:

Note: Don't change the arguments names.

```
TF_VAR_ecr_name= Name of the ECR Privare repository which will be created.

TF_VAR_region= Region of the deployment on AWS.

TF_VAR_image_tag= TAG of the image on ECR.

TF_VAR_lambda_name= Name of the Lambda which will be deployed.

TF_VAR_lambda_description= Description of the Lambda that will be deployed.

```

Put your application code on the /app directory.
The code must have a main file with the lambda_handler function which will be the code executed by Lambda.

Optionally set dependencies of the project in the app/requirements.txt.

The Dockerfile runs by default the main.py file with python3.8 runtime on Lambda. Make any changes to the Dockerfile as needed.

Run 'make deploy' to deploy the solution!

To destroy the resources, just run make destroy.
