class RemoveBadgeIdFromReward < ActiveRecord::Migration[6.1]
  def change
    remove_column :rewards, :badge_id
  end
end
