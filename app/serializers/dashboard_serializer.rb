class DashboardSerializer < ActiveModel::Serializer
  attributes :top_3_contributors, :heros_of_the_month, :overall_stats

  def top_3_contributors
    top_3 = User.top_contributors.limit(3)
    top_3.map do |top_contributor|
      badges_count = top_contributor.rewards.approved.joins(:category_reason).group("category_reasons.badge").count
      {
        user_id: top_contributor.id,
        first_name: top_contributor.first_name,
        last_name: top_contributor.last_name,
        photo_url: top_contributor.photo_url,
        total_count: top_contributor.badges_count,
        badges: {
          gold: badges_count[CategoryReason.badges[:gold]].to_i,
          silver: badges_count[CategoryReason.badges[:silver]].to_i,
          bronze: badges_count[CategoryReason.badges[:bronze]].to_i
        }
      }
    end
  end

  def heros_of_the_month
    top_3 = User.heros_of_the_month.limit(3)
    top_3.map do |hero_of_the_month|
      badges_count = hero_of_the_month.rewards.approved.joins(:category_reason).group("category_reasons.badge").count
      [{
        user_id: hero_of_the_month.id,
        first_name: hero_of_the_month.first_name,
        last_name: hero_of_the_month.last_name,
        photo_url: hero_of_the_month.photo_url,
        total_count: hero_of_the_month.badges_count,
        badges: {
          gold: badges_count[CategoryReason.badges[:gold]].to_i,
            silver: badges_count[CategoryReason.badges[:silver]].to_i,
            bronze: badges_count[CategoryReason.badges[:bronze]].to_i
        }
      }]
    end
  end

  def overall_stats
    rewards_count = Reward.approved.group(:category_id).count

    Category.all.map do |category|
      badges_count = Reward.approved.joins(:category, :category_reason).where(category: { id: category.id }).group("category_reasons.badge").count
      {
        category_id: category.id,
        category_name: category.name,
        total_badge_count: rewards_count[category.id].to_i,
        badges: {
          gold: badges_count[CategoryReason.badges[:gold]].to_i,
          silver: badges_count[CategoryReason.badges[:silver]].to_i,
          bronze: badges_count[CategoryReason.badges[:bronze]].to_i,
        }
      }
    end
  end
end
