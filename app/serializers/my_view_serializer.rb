class MyViewSerializer < ActiveModel::Serializer
  attributes :badges_by_category, :badges_tally

  def badges_by_category
    badge_counts = {}
    object.rewards.approved.group_by(&:category).each do |category, rewards|
      badge_counts[category.name] = rewards.count
    end
    badge_counts
  end

  def badges_tally
    badges = object.rewards.approved.includes(:category_reason).map { |r| r.badge }
    badges.tally
  end
end
