class ConversionsController < ApplicationController
  def index
    respond_to do |format|
      format.json { render json: Conversion.where(currency_id: currency.id) }
    end
  end

  private

  def currency
    @currency = Currency.where(code: params[:currency_code].upcase).first
  end
end
