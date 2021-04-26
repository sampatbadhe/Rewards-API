FactoryBot.define do
  factory :reward do
    user
    category
    category_reason
    activity_date { Time.zone.now }
    comments { 'Other' }
  end
end
