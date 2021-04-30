require 'rails_helper'

RSpec.describe 'Users', type: :request do
  let(:user) { create(:user) }

  describe 'GET /api/v1/user' do
    context 'When User is logged in' do
      before { login(user) }

      it 'returns current logged in user details with status code 200' do
        get '/api/v1/user'
        expect(json).not_to be_empty
        expect(json['user'].size).to eq(5)
        expect(json['user']).to have_key('id')
        expect(json['user']).to have_key('email')
        expect(json['user']).to have_key('photo_url')
        expect(response).to have_http_status(200)
      end
    end

    context 'When User is not logged in' do
      it 'returns a failure message' do
        get '/api/v1/user'
        expect(response.body).to match(/Invalid token/)
        expect(response).to have_http_status(422)
      end
    end
  end
end
