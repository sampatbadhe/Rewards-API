require 'rails_helper'

RSpec.describe 'Dashboard', type: :request do
  let(:user) { create(:user) }

  describe 'GET /api/v1/dashboard' do
    context 'When User is logged in' do
      before { login(user) }

      it 'returns rewards stats with status code 200' do
        get '/api/v1/dashboard'
        expect(json).not_to be_empty
        expect(json["dashboard"].keys).to include("top_3_rank_contributors", "heroes_of_the_last_month", "overall_stats")
        expect(response).to have_http_status(200)
      end
    end

    context 'When User is not logged in' do
      it 'returns a failure message' do
        get '/api/v1/dashboard'
        expect(response.body).to match(/Invalid token/)
        expect(response).to have_http_status(422)
      end
    end
  end
end
