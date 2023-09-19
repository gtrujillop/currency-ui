class CurrenciesController < ApplicationController
  def index
    @currencies = Currency.all
    respond_to do |format|
      format.json { render json: @currencies }
    end
  end
end
