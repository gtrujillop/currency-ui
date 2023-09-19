# frozen_string_literal: true

class Currency
  include Mongoid::Document
  include Mongoid::Timestamps

  field :symbol, type: String
  field :name, type: String
  field :symbol_native, type: String
  field :decimal_digits, type: Integer
  field :rounding, type: Integer
  field :code, type: String
  field :name_plural, type: String

  validates_uniqueness_of :code

  has_many :conversions
end
