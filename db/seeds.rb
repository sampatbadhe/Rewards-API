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

%i[Gold Silver Bronze].each do |badge|
  Badge.find_or_create_by!(name: badge)
end


{
  'KFC' => { 'Meeting' => 'Bronze', 'Organize Event' => 'Silver' },
  'COE' => { 'Meeting' => 'Bronze', 'Organize Event' => 'Silver' },
  'Hiring' => { 'Interview' => 'Bronze', 'Code Review' => 'Bronze', 'Prepared question set' => 'Bronze' },
  'Referral' => { 'Gifted a Career' => 'Gold' },
  'Others' => { 'New Initiative Implemented' => 'Bronze', 'Improved Existing Process' => 'Bronze', 'Other' => 'Bronze' }
}.each do |category_name, category_reasons|
  category = Category.find_or_create_by!(name: category_name)
  category_reasons.each do |reason, badge|
    category_reason = CategoryReason.find_or_create_by(category_id: category.id, reason: reason)
    CategoryReasonBadge.find_or_create_by(category_id: category.id, category_reason_id: category_reason.id, badge_id: Badge.find_or_create_by!(name: badge).id)

  end
end
