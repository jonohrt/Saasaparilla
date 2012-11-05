class InvoiceLineItem < ActiveRecord::Base
  belongs_to :invoice 
  attr_accessible :description, :from, :to, :price
end
