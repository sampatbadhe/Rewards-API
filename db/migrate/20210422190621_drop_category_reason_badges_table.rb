class DropCategoryReasonBadgesTable < ActiveRecord::Migration[6.1]
  def up
    drop_table :category_reason_badges
  end

  def down
    fail ActiveRecord::IrreversibleMigration
  end
end
