class CreateClaimGrantStatuses < ActiveRecord::Migration[6.1]
  def change
    create_table :claim_grant_statuses do |t|
      t.string :granted_status

      t.timestamps
    end
  end
end
