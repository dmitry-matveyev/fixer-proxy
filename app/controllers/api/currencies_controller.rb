# frozen_string_literal: true

module Api
  class CurrenciesController < ApplicationController
    def show
      render json: Api::CurrencyService.call
    end
  end
end
