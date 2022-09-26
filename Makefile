SHELL:=/bin/bash

.PHONY: build
.SILENT: integration-test

build:
	sam build
	
deploy-infra:
	sam build && aws-vault exec my-user --no-session -- sam deploy

integration-test:
	FIRST=$$(curl -s "https://jhhnuojho5.execute-api.us-east-1.amazonaws.com/Prod/get"); \
	curl -s "https://jhhnuojho5.execute-api.us-east-1.amazonaws.com/Prod/put"; \
	SECOND=$$(curl -s "https://jhhnuojho5.execute-api.us-east-1.amazonaws.com/Prod/get"); \
	echo "Comparing if first count ($$FIRST) is less than (<) second count ($$SECOND)"; \
	if [[ $$FIRST -le $$SECOND ]]; then echo "PASS"; else echo "FAIL";  fi