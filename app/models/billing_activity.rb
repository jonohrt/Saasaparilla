class BillingActivity < ActiveRecord::Base
  belongs_to :subscription
  has_one :invoice
  has_one :transaction
  
  MESSAGES = {:success => "Thank you for your payment."}
  scope :recent, order("created_at DESC")
  
  scope :limit, lambda {|num|
    limit(num)
    }
end