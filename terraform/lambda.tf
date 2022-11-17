resource "aws_lambda_function" "refuse_collection" {
  filename      = "../refuse-collection.zip"
  function_name = "refuse-collection-notification"
  role          = aws_iam_role.lambda_role.arn
  handler       = "index.handler"
  runtime       = "nodejs14.x"
  depends_on    = [aws_iam_role_policy_attachment.attach_iam_policy_to_iam_role]
  timeout       = 30
  environment {
    variables = {
      collectionApi = "https://my.haringey.gov.uk/getdata.aspx?RequestType=LocalInfo&ms=mapsources/MyHouse&format=JSON&group=Property%20details|Refuse%20collection%20dates&uid=",
      doorNumber    = ""
      locationApi   = "https://my.haringey.gov.uk/getdata.aspx?service=LocationSearch&RequestType=LocationSearch&pagesize=80&startnum=1&gettotals=false&mapsource=mapsources/MyHouse&location="
      phoneNumber   = ""
      postCode      = ""
    }
  }
  layers = [ aws_lambda_layer_version.lambda_layer.arn ]
}

resource "aws_lambda_layer_version" "lambda_layer" {
  filename   = "../refuse-collection-node-modules.zip"
  layer_name = "refuse-collection-node-modules"
  compatible_runtimes = ["nodejs14.x"]
}