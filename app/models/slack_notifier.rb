class SlackNotifier
  attr_reader :client

  # 環境SLACK_WEBHOOK_URLにwebhook urlを格納
  WEBHOOK_URL = "https://hooks.slack.com/services/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"
  CHANNEL = "#health_check"
  USER_NAME = "Health_check_Reminder"

  def initialize
    @client = Slack::Notifier.new(WEBHOOK_URL, channel: CHANNEL, username: USER_NAME)
  end

  def send(message)
    Slack::Notifier.new(WEBHOOK_URL, channel: CHANNEL, username: USER_NAME).ping(message)
  end
end
