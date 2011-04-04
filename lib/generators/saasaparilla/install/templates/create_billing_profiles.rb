class CreateBillingProfiles < ActiveRecord::Migration
  def self.up
    create_table :billing_profiles do |t|
      t.integer :billable_id
      t.integer :customer_cim_id
      t.integer :customer_payment_profile_id

      t.timestamps
    end
  end

  def self.down
    drop_table :billing_profiles
  end
end
