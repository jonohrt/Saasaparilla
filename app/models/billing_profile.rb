class BillingProfile < ActiveRecord::Base
  validates_presence_of :customer_cim_id
end
