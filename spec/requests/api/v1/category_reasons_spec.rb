require 'rails_helper'

RSpec.describe 'CategoryReasons', type: :request do
  let(:user) { create(:user) }

  describe 'GET /api/v1/category_reasons' do
    context 'When User is logged in' do
      before do
        login(user)
        create(:category_reason)
      end

      it 'returns list of CategoryReasons with status code 200' do
        get '/api/v1/category_reasons'
        expect(json).not_to be_empty
        expect(json['category_reasons'].size).to eq(1)
        expect(json['category_reasons'].first).to have_key('category_name')
        expect(json['category_reasons'].first).to have_key('reason')
        expect(json['category_reasons'].first).to have_key('badge')
        expect(response).to have_http_status(200)
      end
    end

    context 'When User is not logged in' do
      it 'returns a failure message' do
        get '/api/v1/category_reasons'
        expect(response.body).to match(/Invalid token/)
        expect(response).to have_http_status(422)
      end
    end
  end
end
