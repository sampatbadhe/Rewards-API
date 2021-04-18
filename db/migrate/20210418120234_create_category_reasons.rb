class CreateCategoryReasons < ActiveRecord::Migration[6.1]
  def change
    create_table :category_reasons do |t|
      t.references :category
      t.string :reason

      t.timestamps
    end
  end
end
