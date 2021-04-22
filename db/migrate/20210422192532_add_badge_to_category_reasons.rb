class AddBadgeToCategoryReasons < ActiveRecord::Migration[6.1]
  def change
    add_column :category_reasons, :badge, :string
  end
end
