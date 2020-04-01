FROM bedrock/blueprint-base

RUN apk update && apk upgrade
RUN apk add --no-cache --update docker

ADD *.tf /bootstrap/
