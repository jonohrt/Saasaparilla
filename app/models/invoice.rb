class Invoice < ActiveRecord::Base
  belongs_to :billing_activity
  has_many :invoice_line_items

  after_create :create_invoice_line_item
  after_create :generate_billing_activity
  after_create :send_invoice_created_email
  attr_accessor :subscription, :price, :from, :to

  
  def amount
    invoice_line_items.sum(:price)
  end
  
  private


    def create_invoice_line_item
      self.invoice_line_items.create(:price => price, :from => from, :to => to )
    end


    def generate_billing_activity
      self.create_billing_activity(:message => "<a href='/subscription/invoices/#{self.id}'>Invoice</a>", :subscription => subscription, :amount => amount, :invoice => self)
    end
    
    def send_invoice_created_email
      Saasaparilla::Notifier.invoice_created(billing_activity.subscription, self).deliver
    end
    
end
