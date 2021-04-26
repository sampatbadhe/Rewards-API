require 'rails_helper'

RSpec.describe 'Rewards', type: :request do
  let(:user) { create(:user) }
  let(:category) { create(:category) }
  let(:category_reason) { create(:category_reason, category: category) }
  let!(:reward) { create(:reward, user: user) }

  describe 'GET /api/v1/rewards' do
    context 'When User is logged in' do
      before { login(user) }

      it 'returns all rewards with status code 200' do
        get '/api/v1/rewards'
        expect(json).not_to be_empty
        expect(json['rewards'].size).to eq(1)
        expect(json['rewards'].first).to have_key('id')
        expect(response).to have_http_status(200)
      end
    end

    context 'When User is not logged in' do
      it 'returns a failure message' do
        get '/api/v1/rewards'
        expect(response.body).to match(/Invalid token/)
        expect(response).to have_http_status(422)
      end
    end
  end

  describe 'POST /api/v1/rewards' do
    let(:valid_attributes) { { reward: { activity_date: Time.zone.now, category_id: category.id, category_reason_id: category_reason.id } } }

    context 'When User is logged in' do
      before { login(user) }

      it 'creates a reward with valid attributes' do
        post '/api/v1/rewards', params: valid_attributes
        expect(json['reward']['status']).to eq('pending')
        expect(response).to have_http_status(201)
      end

      it 'returns validation message with invalid attributes' do
        post '/api/v1/rewards', params: { reward: { activity_date: nil } }
        expect(json['activity_date'].first).to match(/["can't be blank"]/)
        expect(response).to have_http_status(422)
      end
    end

    context 'When User is not logged in' do
      it 'returns a login failure message' do
        post '/api/v1/rewards', params: valid_attributes
        expect(response.body).to match(/Invalid token/)
        expect(response).to have_http_status(422)
      end
    end
  end

  describe 'GET /api/v1/rewards/:id' do
    context 'When User is logged in' do
      before { login(user) }

      context 'When record exists' do
        it 'returns the reward with status code 200' do
          get "/api/v1/rewards/#{reward.id}"
          expect(json['reward']).not_to be_empty
          expect(json['reward']).to have_key('id')
          expect(response).to have_http_status(200)
        end
      end

      context 'When record does not exists' do
        it 'returns a not found message' do
          get '/api/v1/rewards/500'
          expect(response.body).to match(/Couldn't find Reward/)
          expect(response).to have_http_status(404)
        end
      end
    end

    context 'When User is not logged in' do
      it 'returns a failure message' do
        get '/api/v1/rewards/1'
        expect(response.body).to match(/Invalid token/)
        expect(response).to have_http_status(422)
      end
    end
  end

  describe 'PUT /api/v1/rewards/:id' do
    let(:valid_attributes) { { reward: { activity_date: Time.zone.now } } }

    context 'When User is logged in' do
      before { login(user) }

      it 'updates a reward with valid attributes' do
        put "/api/v1/rewards/#{reward.id}", params: valid_attributes
        expect(json['reward']['status']).to eq('pending')
        expect(response).to have_http_status(200)
      end

      it 'returns validation message with invalid attributes' do
        put "/api/v1/rewards/#{reward.id}", params: { reward: { activity_date: nil } }
        expect(json['activity_date'].first).to match(/["can't be blank"]/)
        expect(response).to have_http_status(422)
      end
    end

    context 'When User is not logged in' do
      it 'returns a login failure message' do
        put "/api/v1/rewards/#{reward.id}", params: valid_attributes
        expect(response.body).to match(/Invalid token/)
        expect(response).to have_http_status(422)
      end
    end
  end
end
