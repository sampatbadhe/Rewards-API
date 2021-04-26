require 'rails_helper'

RSpec.describe CategoryReason, type: :model do
  let(:category_reason) { create(:category_reason, reason: 'Organize Event') }

  it { is_expected.to validate_presence_of(:reason) }
  it { is_expected.to validate_presence_of(:badge) }

  describe 'Instance Methods' do
    describe '#name' do
      it 'returns reason for the CategoryReason' do
        expect(category_reason.name).to eq('Organize Event')
      end
    end
  end
end
