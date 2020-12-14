class Fixer::RateService < BaseService
  def initialize(date:, base:, target:)
    self.date = date
    self.target = target 
  end

  def call
    response = Fixer::get_request(path: date, params: {symbols: target})
    return unless response.is_a?(Net::HTTPSuccess)

    data = JSON.parse(response.body)
    return unless data['success']
    
    data['rates'][target]
  end

  private

  attr_accessor :date, :target
end
