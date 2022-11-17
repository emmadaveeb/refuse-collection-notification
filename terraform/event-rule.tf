resource "aws_cloudwatch_event_rule" "schedule" {
  name                = "schedule-refuse-collection-notification-lambda"
  description         = "Schedule refuse collection lambda every weekday"
  schedule_expression = "cron(0 19 ? * sun-fri *)"
}

resource "aws_cloudwatch_event_target" "lambda" {
  rule = aws_cloudwatch_event_rule.schedule.name
  arn  = aws_lambda_function.refuse_collection.arn
}

resource "aws_lambda_permission" "lambda_permision" {
  principal     = "events.amazonaws.com"
  action        = "lambda:InvokeFunction"
  function_name = aws_lambda_function.refuse_collection.function_name 
  source_arn    = aws_cloudwatch_event_rule.schedule.arn
}