data "archive_file" "zip_the_lambda_code" {
  type        = "zip"
  source_dir  = "../lambda"
  output_path = "../refuse-collection.zip"
}

data "archive_file" "zip_the_node_modules" {
  type        = "zip"
  source_dir  = "../lambda-layer"
  output_path = "../refuse-collection-node-modules.zip"
}