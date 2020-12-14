class Fixer::CurrencyService < BaseService
  PATH = 'latest'.freeze

  def call
    response = Fixer::get_request(path: PATH)
    return unless response.is_a?(Net::HTTPSuccess)

    data = JSON.parse(response.body)
    return unless data['success']
    
    data['rates'].keys
  end
end
