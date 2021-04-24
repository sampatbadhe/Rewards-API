require 'rails_helper'

RSpec.describe User, type: :model do
  let(:user) { create(:user, first_name: 'John', last_name: 'Doe') }

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
      # need to complete spec
    end
  end
end
