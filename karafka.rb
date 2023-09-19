# frozen_string_literal: true

class KarafkaApp < Karafka::App
  setup do |config|
    config.kafka = { 'bootstrap.servers': '127.0.0.1:9092' }
    config.client_id = 'currency_app'
    config.concurrency = 2
    config.max_wait_time = 500 # 0.5 second
    # Recreate consumers with each batch. This will allow Rails code reload to work in the
    # development mode. Otherwise Karafka process would not be aware of code changes
    config.consumer_persistence = !Rails.env.development?
    config.strict_topics_namespacing = false
  end

  Karafka.monitor.subscribe(Karafka::Instrumentation::LoggerListener.new)
  # Karafka.monitor.subscribe(Karafka::Instrumentation::ProctitleListener.new)
  # Karafka.producer.monitor.subscribe(
  #   WaterDrop::Instrumentation::LoggerListener.new(
  #     Karafka.logger,
  #     # If you set this to true, logs will contain each message details
  #     # Please note, that this can be extensive
  #     log_messages: false
  #   )
  # )

  routes.draw do
    active_job_topic :default do
      # Expire jobs after 1 day
      config(partitions: 5, 'retention.ms': 86_400_000)
    end

    topic 'currency-topic.currency_data.conversions' do
      consumer ConversionsConsumer
    end
  end
end

# Karafka::Web.enable!

# You can tag your processes with any info you want and it is going to be visible via the Web UI
# git_hash = `git rev-parse --short HEAD`.strip
# Karafka::Process.tags.add(:commit, "##{git_hash}")
