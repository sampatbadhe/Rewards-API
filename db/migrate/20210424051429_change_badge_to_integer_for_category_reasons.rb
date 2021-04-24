class ChangeBadgeToIntegerForCategoryReasons < ActiveRecord::Migration[6.1]
  def up
    change_column :category_reasons, :badge, :integer, using: 'badge::integer'
  end

  def down
    change_column :category_reasons, :badge, :string
  end
end
