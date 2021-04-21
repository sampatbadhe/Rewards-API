class AddStatusToRewards < ActiveRecord::Migration[6.1]
  def change
    add_column :rewards, :status, :string
  end
end
