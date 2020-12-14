# frozen_string_literal: true

module Api
  class CurrencyService < BaseService
    def call
      Fixer::CurrencyService.call
    end
  end
end
