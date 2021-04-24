require 'rails_helper'

RSpec.describe Reward, type: :model do
  let(:category) { create(:category) }
  let(:todays_date) { Time.zone.now }
  let(:yesterdays_date) { Time.zone.yesterday }

  it { is_expected.to validate_presence_of(:activity_date) }
  it { is_expected.to validate_presence_of(:status) }

  describe 'Scopes' do
    before do
      create(:reward, category_id: category.id)
      create(:reward)
    end

    describe '.by_date_range' do
      it 'returns rewards within the given date range' do
        expect(Reward.by_date_range(todays_date, todays_date + 1.day).count).to eq(2)
        expect(Reward.by_date_range(yesterdays_date - 2.days, yesterdays_date).count).to eq(0)
      end
    end

    describe '.by_category_id' do
      it 'returns rewards having specific category' do
        expect(Reward.count).to eq(2)
        expect(Reward.by_category_id(category.id).count).to eq(1)
      end
    end
  end
end
