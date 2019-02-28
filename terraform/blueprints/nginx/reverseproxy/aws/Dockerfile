FROM bedrock/base

ADD export.sh /bootstrap/

ADD *.tf /bootstrap/
ADD cloudformation /bootstrap/cloudformation
ADD userdata /bootstrap/userdata

ENV TF_VAR_cloudformation_path="/bootstrap/cloudformation"
ENV TF_VAR_userdata_path="/bootstrap/userdata"
