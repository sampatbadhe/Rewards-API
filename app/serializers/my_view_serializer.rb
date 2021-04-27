class MyViewSerializer < ActiveModel::Serializer
  attributes :badges_by_category, :badges_tally

  def badges_by_category
    Category.all.map do |category|
      {
        category_id: category.id,
        category_name: category.name,
        total_badge_count: object.rewards.approved.by_category_id(category.id).count
      }
    end
  end

  def badges_tally
    default_badges_count = { 'gold' => 0, 'silver' => 0, 'bronze' => 0 }
    badges = object.rewards.approved.includes(:category_reason).map(&:badge)
    default_badges_count.merge(badges.tally)
  end
end
