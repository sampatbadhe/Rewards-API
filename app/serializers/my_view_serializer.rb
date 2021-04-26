class MyViewSerializer < ActiveModel::Serializer
  attributes :badges_by_category, :badges_tally

  def badges_by_category
    badge_counts = { 'KFC' => 0, 'COE' => 0, 'Hiring' => 0, 'Referral' => 0, 'Others' => 0 }
    object.rewards.approved.group_by(&:category).each do |category, rewards|
      badge_counts[category.name] = rewards.count
    end
    badge_counts
  end

  def badges_tally
    default_badges_count = { 'gold' => 0, 'silver' => 0, 'bronze' => 0 }
    badges = object.rewards.approved.includes(:category_reason).map(&:badge)
    badges.tally.merge!(default_badges_count) { |_key, old_value, new_value| [old_value, new_value].max }
  end
end
