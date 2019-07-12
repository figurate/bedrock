FROM bedrock/base

ADD export.sh /bootstrap/

ADD *.tf /bootstrap/
ADD templates /bootstrap/templates

ENV TF_VAR_template_path="/bootstrap/templates"
