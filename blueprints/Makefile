SHELL:=/bin/bash
REGISTRY?=bedrock
DOCKERFILES=$(shell find * -mindepth 1 -type f -name Dockerfile)
IMAGES=$(subst /,-,$(subst /Dockerfile,,$(DOCKERFILES)))
DEPENDS=.depends.mk
TAGS?=latest
BUILD_ARGS?=

.PHONY: all clean tag push docs format $(IMAGES)

all: $(IMAGES)

clean:
	rm -f $(DEPENDS)

$(DEPENDS): $(DOCKERFILES) Makefile
	grep "^FROM ${REGISTRY}/" ${DOCKERFILES} | \
		awk -F '/Dockerfile:FROM ${REGISTRY}/' '{ print $$1 " " $$2 }' | \
		sed 's/[:/]/-/g' | awk '{ print $$1 ": " $$2 }' > $@

sinclude $(DEPENDS)

$(IMAGES): %:

ifeq (clean,$(filter clean,$(MAKECMDGOALS)))
	docker rmi $(REGISTRY)/$@
endif

	docker build ${BUILD_ARGS} --build-arg HTTP_PROXY=${http_proxy} -t $(REGISTRY)/$@ --network=host $(subst -,/,$@)

ifeq (tag,$(filter tag,$(MAKECMDGOALS)))
	echo $(TAGS) | tr "/," "-\n" | xargs -n1 -I % docker tag $(REGISTRY)/$@ $(REGISTRY)/$@:%
endif

ifeq (push,$(filter push,$(MAKECMDGOALS)))
	echo $(TAGS) | tr "/," "-\n" | xargs -n1 -I % docker push $(REGISTRY)/$@:%
endif

ifeq (docs,$(filter docs,$(MAKECMDGOALS)))
	docker run --rm -v "${PWD}:/work" tmknom/terraform-docs markdown $(subst -,/,$@)/ >$(subst -,/,$@)/README.md
endif

ifeq (format,$(filter format,$(MAKECMDGOALS)))
	terraform fmt -list=true $(subst -,/,$@)/
endif
