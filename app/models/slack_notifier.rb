class SlackNotifier
  attr_reader :client

  # 環境SLACK_WEBHOOK_URLにwebhook urlを格納
  WEBHOOK_URL = ENV.fetch('SLACK_WEBHOOK_URL')
  CHANNEL = "#health_check"
  USER_NAME = "Health_check_Reminder"

  def initialize
    @client = Slack::Notifier.new(WEBHOOK_URL, channel: CHANNEL, username: USER_NAME)
  end

  def send(message)
    Slack::Notifier.new(WEBHOOK_URL, channel: CHANNEL, username: USER_NAME).ping(message)
  end
end
