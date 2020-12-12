class FixerService < BaseService
  ACCESS_KEY = 'd83179e5328bfb84b733ac6a57aba9ba'
  URL = 'http://data.fixer.io/api/'

  def initialize(date:, base:, target:)
    self.date = date
    self.target = target 
  end

  def call
    response = do_request
    return unless response.is_a?(Net::HTTPSuccess)

    data = JSON.parse(response.body)
    return unless data['success']
    
    data['rates'][target]
  end

  private

  attr_accessor :date, :target

  def url_with_date
    [URL, date].join
  end

  def do_request
    uri = URI(url_with_date)
    params = { symbols: target, access_key: ACCESS_KEY }
    uri.query = URI.encode_www_form(params)

    Net::HTTP.get_response(uri)
  end
end