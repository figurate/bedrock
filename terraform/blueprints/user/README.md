# Provision users/groups

Support for creation of users and groups in the following environments:

* Amazon Web Services (AWS)
    
### Example:

    $ accelerator/build.sh && docker run --rm -it -p8081:80 -d bedrock/accelerator

    $ TF_VAR_users=fred,betty,barney TF_VAR_groups=power-user,ecs-admin TF_VAR_region=ap-southeast-2 bash <(curl http://localhost:8081/user/config.sh)
    
    $ bash <(curl http://localhost:8081/user/aws.sh)