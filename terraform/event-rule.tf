resource "aws_cloudwatch_event_rule" "schedule" {
  name                = "schedule-refuse-collection-notification-lambda"
  description         = "Schedule refuse collection lambda every weekday"
  schedule_expression = "cron(0 0 ? * mon-fri *)"
}

resource "aws_cloudwatch_event_target" "lambda" {
  rule = aws_cloudwatch_event_rule.schedule.name
  arn  = aws_lambda_function.refuse_collection.arn
}
