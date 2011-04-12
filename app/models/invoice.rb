class Invoice < ActiveRecord::Base
  belongs_to :billing_activity
  has_many :invoice_line_items

  after_create :generate_billing_activity

  attr_accessor :account
  
  
  def amount
    invoice_line_items.sum(:price)
  end
  
  
  def create_invoice_line_item(price, from, to)
    self.invoice_line_items.create(:price => price, :from => from, :to => to )
  end
  
  private
    def generate_billing_activity

      self.create_billing_activity(:message => "<a href='/account/invoices/#{self.id}'>Invoice</a>", :account => account, :amount => amount, :invoice => self)

    end
end
