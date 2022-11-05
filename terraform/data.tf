data "archive_file" "zip_the_lambda_code" {
  type        = "zip"
  source_dir  = "../lambda"
  output_path = "../refuse-collection-lambda.zip"
}