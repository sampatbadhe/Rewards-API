class RemoveSenderIdFromNotifications < ActiveRecord::Migration[6.1]
  def change
    remove_column :notifications, :sender_id, :integer
  end
end
