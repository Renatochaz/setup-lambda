## ttt
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

include .env
export $(shell sed 's/=.*//' .env)

init:
	@cd ecr && terraform init && terraform fmt

plan:
	@cd ecr && terraform fmt && terraform plan