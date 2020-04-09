/*
 * Provision an AppMesh service mesh for the ECS cluster.
 */
resource "aws_appmesh_mesh" "cluster" {
  count = var.appmesh_enabled == "True" ? 1 : 0
  name  = local.cluster_name
}
