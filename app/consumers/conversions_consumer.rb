class ConversionsConsumer < ApplicationConsumer
  def consume
    messages.each do |message|
      data = JSON.parse(message.payload.dig('payload', 'after'))
      conversion = Conversion.create!(
        value: data['value'].values[0].to_f,
        code: data['code'],
        datetime_of_update: Time.at(data['datetime_of_update'].values[0].to_s.chomp('000').to_i).to_datetime,
        created_at: Time.at(data['updated_at'].values[0].to_s.chomp('000').to_i).to_datetime,
        currency_id: data['currency_id'].values[0]
      )
      Rails.logger.debug("New conversion synced: #{conversion.inspect}")
    end
  end
end
