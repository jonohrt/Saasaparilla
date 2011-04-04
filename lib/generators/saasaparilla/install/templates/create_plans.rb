class CreatePlans < ActiveRecord::Migration
  def self.up
    create_table :plans do |t|
      t.string :name
      t.string :billing_period
      t.integer :subscription_id
      t.float :price
      
      t.text :dynamic_attributes
      t.timestamps
    end
  end

  def self.down
    drop_table :plans
  end
end

