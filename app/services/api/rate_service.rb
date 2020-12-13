# frozen_string_literal: true

module Api
  class RateService < BaseService
    def initialize(params)
      self.date = params[:date]
      self.base = params[:base]
      self.target = params[:target]
    end

    def call
      rate = scope.first

      # TODO: check if we realy need a decimal column in db
      #       decimal is converted to json as string
      #       float is converted as numeric
      #       users are expecting numeric response now
      return rate.value.to_f if rate

      value = FixerService.call(date: date, base: base, target: target)
      return unless value.present?

      # TODO: move to background job to provide a faster response
      rate = scope.new
      rate.value = value
      # do not raise exception here by purpose:
      # user should receive the rate even if we could not save the record to db
      rate.save

      value
    end

    private

    attr_accessor :date, :base, :target

    def scope
      Rate.where(created_at: date, base: base, target: target)
    end
  end
end
