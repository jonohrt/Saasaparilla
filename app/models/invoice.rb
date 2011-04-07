class Invoice < ActiveRecord::Base
  belongs_to :billing_activity
  has_many :invoice_line_items
end
