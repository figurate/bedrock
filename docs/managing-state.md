# Managing Bedrock State

The Terraform state for blueprints is maintained in an AWS S3 bucket.

## Migrating blueprints

Occasionally you may have a need to migrate existing state to a new blueprint key. The following instructions
demonstrate how to do this:

1. Ensure the old blueprint state is locally updated:

        $  blueprint <old_blueprint_id> [-t <old_blueprint_tag>]
    
2. Rename the blueprint state on the filesystem:

        $ mv ~/.bedrock/<old_blueprint_id>/<old_blueprint_tag> ~/.bedrock/<new_blueprint_id>/<new_blueprint_tag>

3. Initialise the new blueprint state using Terraform `-force-copy` option:

        $ TF_ARGS=-force-copy blueprint <new_blueprint_id> [-t <new_blueprint_tag>]

    
_NOTE: If you don't provide a blueprint tag the default tag will be the same as the blueprint id._
