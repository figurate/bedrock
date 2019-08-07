FROM hashicorp/terraform:0.11.14

WORKDIR /work

ADD *.sh *.tf /bootstrap/

ENTRYPOINT ["/bin/sh"]

CMD ["/bootstrap/run.sh"]