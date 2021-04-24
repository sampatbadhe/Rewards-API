require 'rails_helper'

RSpec.describe 'Authentication', type: :request do
  let(:user) { create(:user) }
  let(:login_url) { '/api/v1/auth/google_signup' }
  let(:valid_params) do
    {
      user_auth: {
        email:      user.email,
        google_uid: user.google_uid,
        first_name: user.first_name,
        last_name:  user.last_name
      }
    }
  end

  describe 'POST /api/v1/auth/google_signup' do
    context 'when login credentials are correct' do
      before { post login_url, params: valid_params }

      it 'returns 200' do
        expect(response).to have_http_status(200)
      end

      it 'returns valid token' do
        expect(json['token']).to be_present
      end
    end

    context 'when login credentials are incorrect' do
      before { post login_url, params: { user_auth: { email: user.email, google_uid: nil }} }

      it 'returns unathorized status' do
        expect(response.status).to eq 422
      end
    end
  end

end
