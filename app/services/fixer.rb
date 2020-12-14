module Fixer
  def get_request(path:, params: {})
    uri = URI.join(FIXER_API_URL, path)
    params = params.merge(access_key: FIXER_ACCESS_KEY)
    uri.query = URI.encode_www_form(params)

    Net::HTTP.get_response(uri)
  end

  module_function :get_request 
end