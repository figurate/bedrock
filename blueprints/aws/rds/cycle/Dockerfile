FROM bedrock/blueprint-base

ADD export.sh /bootstrap/

ADD *.tf /bootstrap/
ADD lambda /bootstrap/lambda

ENV TF_VAR_lambda_path="/bootstrap/lambda"
