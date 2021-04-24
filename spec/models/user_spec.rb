require 'rails_helper'

RSpec.describe User, type: :model do
  let(:user) { create(:user, first_name: 'John', last_name: 'Doe') }
  let(:new_user) { build(:user) }

  it { is_expected.to validate_presence_of(:email) }
  it { is_expected.to validate_presence_of(:google_uid) }
  it { is_expected.to validate_presence_of(:first_name) }
  it { is_expected.to validate_presence_of(:last_name) }

  it { is_expected.to have_many(:rewards).dependent(:destroy) }

  describe 'Instance Methods' do
    describe '#full_name' do
      it 'returns full name of the User' do
        expect(user.full_name).to eq('John Doe')
      end
    end
  end
end
