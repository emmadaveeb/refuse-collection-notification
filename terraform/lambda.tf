resource "aws_lambda_function" "refuse_collection" {
  filename      = "../refuse-collection-lambda.zip"
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

}