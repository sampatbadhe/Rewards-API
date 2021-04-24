class ClaimGrantStatusesTable < ActiveRecord::Migration[6.1]
  def up
    drop_table :claim_grant_statuses
  end

  def down
    create_table :claim_grant_statuses do |t|
      t.string :granted_status

      t.timestamps
    end
  end
end
