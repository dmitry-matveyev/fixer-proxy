require 'rails_helper'

RSpec.describe "Api::Rates", type: :request do
  describe '#show' do
    context 'with correct params' do
      context 'when no cache exists' do
        let(:date) { Date.current }
        let(:base) { Rate::EUR }
        let(:target) { Rate::USD }
        let(:value) { 1.2334 }

        let(:do_request) { get "/api/rates/#{date}", params: { base: base, target: target }}
        subject do
          do_request
          json_body
        end

        it { is_expected.to eq(value) }
      end
    end
  end
end