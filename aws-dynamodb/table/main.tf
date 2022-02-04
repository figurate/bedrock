module "table" {
  source = "figurate/dynamodb-table/aws//modules/single-table"

  name = var.name
}
