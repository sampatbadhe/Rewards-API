require 'rails_helper'

RSpec.describe 'Categories', type: :request do
  let(:user) { create(:user) }

  describe 'GET /api/v1/categories' do
    context 'When User is logged in' do
      before do
        login(user)
        create(:category)
      end

      it 'returns list of Categories with status code 200' do
        get '/api/v1/categories'
        expect(json).not_to be_empty
        expect(json['categories'].size).to eq(1)
        expect(json['categories'].first).to have_key('id')
        expect(json['categories'].first).to have_key('name')
        expect(response).to have_http_status(200)
      end
    end

    context 'When User is not logged in' do
      it 'returns a failure message' do
        get '/api/v1/categories'
        expect(response.body).to match(/Invalid token/)
        expect(response).to have_http_status(422)
      end
    end
  end
end
