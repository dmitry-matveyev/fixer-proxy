# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Api::Currencies', type: :request do
  describe '#show' do
    let(:do_request) { get '/api/currencies' }
    subject do
      do_request
      json_body
    end

    let(:expected_body) { { success: true, rates: { 'USD' => 1, 'EUR' => 2 } }.stringify_keys.to_json }
    let(:expected_url) do
      "http://data.fixer.io/api/latest?access_key=#{FIXER_ACCESS_KEY}"
    end

    before do
      stub_request(:get, expected_url)
        .to_return(status: 200, body: expected_body, headers: {})
    end

    it { is_expected.to eq(%w[USD EUR]) }
  end
end
