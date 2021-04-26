FactoryBot.define do
  factory :category_reason do
    category
    reason { 'Meeting' }
    badge { 'bronze' }
  end
end
