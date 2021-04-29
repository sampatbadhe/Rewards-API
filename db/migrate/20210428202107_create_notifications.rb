class CreateNotifications < ActiveRecord::Migration[6.1]
  def change
    create_table :notifications do |t|
      t.integer :recipient_id
      t.integer :sender_id
      t.text :body
      t.boolean :seen, default: false
      t.string :alertable_type
      t.integer :alertable_id

      t.timestamps
    end
  end
end
