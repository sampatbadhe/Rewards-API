class RemoveMobileFromUsers < ActiveRecord::Migration[6.1]
  def change
    remove_column :users, :mobile, :string
  end
end
