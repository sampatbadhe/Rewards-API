class ChangeStatusToIntegerForRewards < ActiveRecord::Migration[6.1]
  def up
    change_column :rewards, :status, :integer, using: 'status::integer'
  end

  def down
    change_column :rewards, :status, :string
  end
end
