FROM bedrock/blueprint-base

ADD export.sh /bootstrap/

ADD *.tf /bootstrap/
ADD userdata /bootstrap/userdata

ENV TF_VAR_userdata_path="/bootstrap/userdata"
