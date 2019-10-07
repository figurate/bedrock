FROM bedrock/blueprint-base

ADD export.sh /bootstrap/

ADD *.tf /bootstrap/
ADD cloudformation /bootstrap/cloudformation
ADD templates /bootstrap/templates

ENV TF_VAR_cloudformation_path="/bootstrap/cloudformation"
ENV TF_VAR_template_path="/bootstrap/templates"
