class CreateRewards < ActiveRecord::Migration[6.1]
  def change
    create_table :rewards do |t|
      t.references :user
      t.date :activity_date
      t.references :category
      t.references :category_reason
      t.references :badge
      t.string :comments
      t.references :claim_grant_status

      t.timestamps
    end
  end
end
