# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
AdminUser.create!(email: 'admin@example.com', password: 'password', password_confirmation: 'password') if Rails.env.development?


%i[Approved Rejected Withdrawn Pending].each do |status|
  ClaimGrantStatus.find_or_create_by!(granted_status: status)
end

{
  'KFC' => { 'Meeting' => 'bronze', 'Organize Event' => 'silver' },
  'COE' => { 'Meeting' => 'bronze', 'Organize Event' => 'silver' },
  'Hiring' => { 'Interview' => 'bronze', 'Code Review' => 'bronze', 'Prepared question set' => 'bronze' },
  'Referral' => { 'Gifted a Career' => 'gold' },
  'Others' => { 'New Initiative Implemented' => 'bronze', 'Improved Existing Process' => 'bronze', 'Other' => 'bronze' }
}.each do |category_name, category_reasons|
  category = Category.find_or_create_by!(name: category_name)
  category_reasons.each do |reason, badge|
    CategoryReason.find_or_create_by(category_id: category.id, reason: reason, badge: badge)
  end
end
