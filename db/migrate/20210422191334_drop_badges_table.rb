class DropBadgesTable < ActiveRecord::Migration[6.1]
  def up
    drop_table :badges
  end

  def down
    fail ActiveRecord::IrreversibleMigration
  end
end
