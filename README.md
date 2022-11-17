Creates an AWS Lambda that sends an SNS notification as a text message the day before refuse or dry recycling collection is due. The APIs used are for London Haringey council. Enter phone number (E.164 format), postcode and door number in lambda environment variables (./terraform/lambda.tf). Enter AWS credentials profile (./terraform/main.tf).

An event rule is created that schedules the lambda to run at 7pm each day sun-fri to check if the next day is a collection day. If a collection day is found, a text is sent.

- If the next day is a dry recycling collection day, the text will contain the message:

    'Your dry recycling is being collected tomorrow.'

-  If the next day is a refuse collection day, the text will contain the message:

    'Your refuse collection day is tomorrow.'

- If the next day is both a refuse and dry recycling collection day, the text will contain the message:

    'Your dry recycling & refuse is being collected tomorrow.'