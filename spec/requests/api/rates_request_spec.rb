# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Api::Rates', type: :request do
  describe '#show' do
    context 'with correct params' do
      let(:date) { Date.current }
      let(:base) { Rate::EUR }
      let(:target) { Rate::USD }
      let(:value) { 1.21116 }

      let(:do_request) { get "/api/rates/#{date}", params: { base: base, target: target } }
      subject do
        do_request
        json_body
      end

      context 'when no cache exists' do
        let(:expected_body) { { success: true, rates: { 'USD' => value } }.stringify_keys.to_json }
        let(:expected_url) do
          "http://data.fixer.io/api/#{date}?access_key=#{FIXER_ACCESS_KEY}&symbols=#{target}"
        end

        before do
          stub_request(:get, expected_url)
            .to_return(status: 200, body: expected_body, headers: {})
        end

        it { is_expected.to eq(value) }
      end

      context 'when cache exists' do
        before { Rate.create(created_at: date, base: base, target: target, value: value) }

        it { is_expected.to eq(value) }
      end
    end
  end
end
