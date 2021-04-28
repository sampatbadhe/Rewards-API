class RemoveClaimGrantStatusIdFromRewards < ActiveRecord::Migration[6.1]
  def change
    remove_column :rewards, :claim_grant_status_id, :bigint
  end
end
