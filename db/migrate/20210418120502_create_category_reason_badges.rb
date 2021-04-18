class CreateCategoryReasonBadges < ActiveRecord::Migration[6.1]
  def change
    create_table :category_reason_badges do |t|
      t.references :category
      t.references :category_reason
      t.references :badge

      t.timestamps
    end
  end
end
