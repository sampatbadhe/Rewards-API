FactoryBot.define do
  factory :user do
    email { "#{Faker::Name.first_name}@example.com" }
    mobile { '1212121212' }
    google_uid { 'abcdxyz' }
    first_name { Faker::Name.first_name }
    last_name { Faker::Name.last_name }
  end
end
