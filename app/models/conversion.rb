# frozen_string_literal: true

class Conversion
  include Mongoid::Document
  include Mongoid::Timestamps

  field :value, type: BigDecimal
  field :code, type: String
  field :datetime_of_update, type: DateTime

  belongs_to :currency
end
