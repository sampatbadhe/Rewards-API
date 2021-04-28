class DashboardSerializer < ActiveModel::Serializer
  attributes :top_3_contributors, :heros_of_the_last_month, :overall_stats

  # returns contributors for top 3 positions
  def top_3_contributors
    top_3 = User.top_contributors.limit(3)
    top_3.map do |user|
      badges_count = user.rewards.approved.joins(:category_reason).group("category_reasons.badge").count
      {
        user_id: user.id,
        first_name: user.first_name,
        last_name: user.last_name,
        photo_url: user.photo_url,
        total_count: user.badges_count,
        badges: {
          gold: badges_count[CategoryReason.badges[:gold]].to_i,
          silver: badges_count[CategoryReason.badges[:silver]].to_i,
          bronze: badges_count[CategoryReason.badges[:bronze]].to_i
        }
      }
    end
  end

  # returns top 5 contributes for last month
  def heros_of_the_last_month
    top_5 = User.heros_of_the_last_month.limit(5)
    top_5.map do |user|
      badges_count = user.rewards.approved.joins(:category_reason).group("category_reasons.badge").count
      [{
        user_id: user.id,
        first_name: user.first_name,
        last_name: user.last_name,
        photo_url: user.photo_url,
        total_count: user.badges_count,
        badges: {
          gold: badges_count[CategoryReason.badges[:gold]].to_i,
            silver: badges_count[CategoryReason.badges[:silver]].to_i,
            bronze: badges_count[CategoryReason.badges[:bronze]].to_i
        }
      }]
    end
  end

  def overall_stats
    rewards_stats = []

    date = Date.current.advance(months: -6).beginning_of_month
    (0..5).each do |i|
      start_date = date.advance(months: i)
      rewards = Reward.approved.by_date_range(start_date, start_date.end_of_month)

      rewards_by_category_count = rewards.group(:category_id).count

      category_stats = Category.all.map do |category|
        badges_count = rewards.joins(:category, :category_reason).where(category: { id: category.id }).group("category_reasons.badge").count
        {
          category_id: category.id,
          category_name: category.name,
          total_badge_count: rewards_by_category_count[category.id].to_i,
          badges: {
            gold: badges_count[CategoryReason.badges[:gold]].to_i,
            silver: badges_count[CategoryReason.badges[:silver]].to_i,
            bronze: badges_count[CategoryReason.badges[:bronze]].to_i,
          }
        }
      end

      rewards_stats << { date: start_date, category_stats: category_stats }
    end

    rewards_stats
  end
end
