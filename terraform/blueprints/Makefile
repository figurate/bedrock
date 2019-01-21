REGISTRY?=bedrock
DOCKERFILES=$(shell find * -mindepth 1 -type f -name Dockerfile)
IMAGES=$(subst /,\:,$(subst /Dockerfile,,$(DOCKERFILES)))
DEPENDS=.depends.mk

.PHONY: all clean tag push docs $(IMAGES)

all: $(IMAGES)

clean:
	rm -f $(DEPENDS)

$(DEPENDS): $(DOCKERFILES) Makefile
	grep '^FROM $(REGISTRY)/' $(DOCKERFILES) | \
		awk -F '/Dockerfile:FROM $(REGISTRY)/' '{ print $$1 " " $$2 }' | \
		sed 's@[:/]@\\:@g' | awk '{ print $$1 ": " $$2 }' > $@

sinclude $(DEPENDS)

$(IMAGES): %:

ifeq (clean,$(filter clean,$(MAKECMDGOALS)))
	docker rmi $(REGISTRY)/$@
endif

	docker build -t $(REGISTRY)/$@ $(subst :,/,$@)

ifeq (tag,$(filter tag,$(MAKECMDGOALS)))
	docker tag $(REGISTRY)/$@ $(REGISTRY)/$@
endif

ifeq (push,$(filter push,$(MAKECMDGOALS)))
	docker push $(REGISTRY)/$@
endif

ifeq (docs,$(filter docs,$(MAKECMDGOALS)))
	docker run --rm -v "${PWD}:/work" tmknom/terraform-docs markdown $(subst :,/,$@)/ >$(subst :,/,$@)/README.md
endif
