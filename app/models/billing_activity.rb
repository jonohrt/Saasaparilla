class BillingActivity < ActiveRecord::Base
  belongs_to :account
  has_one :invoice
  has_one :transaction
  
  MESSAGES = {:success => "Thank you for you payment."}
end