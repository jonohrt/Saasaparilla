class CreateSaasaparillaTables < ActiveRecord::Migration
  def self.up
    create_table :accounts do |t|
      t.integer :billable_id
      t.string :billable_type
      t.float :balance
      t.string :status
      t.integer :customer_cim_id
      t.integer :customer_payment_profile_id
      
      t.timestamps
    end
    
    create_table :credit_cards do |t|
      t.string :expiration_date
      t.string :card_number
      t.integer :account_id
    end
    create_table :subscriptions do |t|
      t.string :status
      t.integer :account_id
      t.integer :plan_id
      t.timestamps
    end
    
    
    create_table :plans do |t|
      t.string :name
      t.string :billing_period
      t.integer :subscription_id
      t.float :price
      t.text :dynamic_attributes
      t.timestamps
    end
    
    create_table :contact_infos do |t|
      t.string :first_name
      t.string :last_name
      t.string :email
      t.string :company
      t.string :address
      t.string :city
      t.string :state
      t.string :zip
      t.string :country
      t.string :phone_number
    
      t.integer :account_id
    end
    
    create_table :billing_activities do |t|
      t.float :amount
      t.string :message
      t.integer :account_id
      t.timestamps
    end
    
    create_table :invoices do |t|
      t.float :total
      t.integer :invoice_number
      t.integer :billing_activity_id
      t.timestamps
    end
    
    create_table :invoice_line_items do |t|
      t.string :description
      t.date :from
      t.date :to
      t.float :price
      t.integer :invoice_id
    end
    
    create_table :transactions do |t|
       t.string :action
       t.integer :amount
       t.boolean :success
       t.string :authorization
       t.string :message
       t.text :params
       t.integer :billing_activity_id
       t.timestamps
    end
    
    
  end

  def self.down
    drop_table :accounts
    drop_table :subscriptions
    drop_table :credit_cards
    drop_table :transactions
    drop_table :contact_infos
    drop_table :plans
    drop_table :invoices
    drop_table :invoice_line_items
    
  end
end