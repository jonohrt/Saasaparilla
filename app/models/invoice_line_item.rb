class InvoiceLineItem < ActiveRecord::Base
  belongs_to :invoice 
end