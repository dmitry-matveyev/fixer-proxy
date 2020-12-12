# frozen_string_literal: true

module Api
  class RatesController < ApplicationController
    def show
      puts params.inspect
      value = Api::RateService.call(permit_params)

      render json: value
    end

    private

    def permit_params
      params.permit(:date, :base, :target)
    end
  end
end
