#!make
os       ?= $(shell uname|tr A-Z a-z)
ifeq ($(shell uname -m),x86_64)
  arch   ?= "amd64"
endif
ifeq ($(shell uname -m),i686)
  arch   ?= "386"
endif
ifeq ($(shell uname -m),aarch64)
  arch   ?= "arm"
endif

include envfile
export $(shell sed 's/=.*//' envfile)

deploy:
	@cd _terraform && terraform init && terraform validate && terraform fmt -recursive && terraform apply -auto-approve

plan:
	@cd _terraform && terraform init && terraform fmt -recursive && terraform plan

destroy:
	@cd _terraform && terraform destroy -auto-approve