FROM hashicorp/terraform:light

WORKDIR /work

ADD *.sh *.tf /bootstrap/

ENTRYPOINT ["/bin/sh"]

CMD ["/bootstrap/run.sh"]