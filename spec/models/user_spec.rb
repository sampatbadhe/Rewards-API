require 'rails_helper'

RSpec.describe User, type: :model do
  let(:user) { create(:user, first_name: 'John', last_name: 'Doe') }
  let(:existing_user_params) do
    {
      email:      user.email,
      google_uid: user.google_uid,
      first_name: user.first_name,
      last_name:  user.last_name
    }
  end

  it { is_expected.to validate_presence_of(:email) }
  it { is_expected.to validate_presence_of(:google_uid) }
  it { is_expected.to validate_presence_of(:first_name) }
  it { is_expected.to validate_presence_of(:last_name) }

  describe 'Instance Methods' do
    describe '#full_name' do
      it 'returns full name of the User' do
        expect(user.full_name).to eq('John Doe')
      end
    end
  end

  describe 'Class Methods' do
    describe '.register_user' do
      context 'When user params are valid' do
        context 'When User is already present in the system' do
          it 'returns the existing user' do
            response = User.register_user(existing_user_params)
            expect(response).to be_valid
            expect(response.email).to eq(user.email)
          end
        end

        context 'When User is not present in the system' do
          it 'creates and returns the new user' do
            valid_params = { email: 'test@example.com', first_name: 'test', last_name: 'user', google_uid: 'qwerty123' }
            response = User.register_user(valid_params)
            expect(response).to be_valid
            expect(response.email).to eq('test@example.com')
          end
        end
      end

      context 'When user params are invalid' do
        it 'returns validation failure message' do
          invalid_params = { email: '', first_name: 'test', last_name: 'user', google_uid: '' }
          expect {
            User.register_user(invalid_params)
          }.to raise_error(ApiErrors::MissingParamsError)
        end
      end
    end
  end
end
