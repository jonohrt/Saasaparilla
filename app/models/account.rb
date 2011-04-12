class Account < ActiveRecord::Base
  
  has_statuses "ok", "overdue", "suspended", "pending_cancel", "canceled"
  has_many :transactions
  has_many :payments
  has_one :subscription
  accepts_nested_attributes_for :subscription
  has_one :contact_info
  accepts_nested_attributes_for :contact_info
  has_many :billing_activities
  belongs_to :billable, :polymorphic => true
  has_one :credit_card
  accepts_nested_attributes_for :credit_card
  before_create :create_cim_profile
  before_create :create_payment_profile
  before_validation :set_status, :on => :create
  before_create :set_initial_balance
  after_rollback :delete_profile
  after_create :bill!
  
  scope :active, where("status != ?", "canceled")
  
  scope :all_billable_accounts, lambda {|date|
    where("billing_date BETWEEN ? and ? and balance > 0.0",  (date - 1.months).to_time, date.to_time)
    }
  
  scope :all_invoiceable, lambda {|date|
    #find all accounts not been invoiced within the last month
    where("billing_date <= ? and (invoiced_on > ? OR invoiced_on is null)", date + 5.days, (date - 1.months).to_time)
    }

  class << self
    def find_and_bill_recurring_accounts
      #find_all_accounts need billing
      @billable_accounts = Account.active.all_billable_accounts(Date.today)
      for account in @billable_accounts
        account.bill!(account.balance)
      end

    end
    
    def find_and_invoice_accounts
      @invoiceable_accounts = Account.active.all_invoiceable(Date.today)
      for account in @invoiceable_accounts
        account.invoice!
      end
    end
  end
  
  def bill!(bill_amount = nil)
    bill_amount ||= balance
    if charge_amount(bill_amount)
      set_next_billing_date
      set_status_ok if balance == 0.0
      return true
    end
  end
  
  def invoice!
    add_to_balance(subscription.plan.price)
    create_invoice
    self.update_attributes(:invoiced_on => Date.today)
    #if invoice_account
    #  set_next_invoice_date()
  end
  
  def cancel
    set_canceled
  end
  
  
  private
  
  def create_invoice
    @invoice = Invoice.create(:account => self, :price => subscription.plan_price, :from => get_beginning_of_billing_cycle, :to => billing_date)
    # @invoice.create_invoice_line_item(subscription.plan_price, get_beginning_of_billing_cycle, billing_date )
 
  end
  
  def get_beginning_of_billing_cycle
    if subscription.monthly?
      return billing_date - 1.months
    elsif subscription.yearly?
      return billing_date - 1.years
    end
  end
  def set_next_billing_date
    if subscription.monthly?
      if billing_date.nil?
        self.update_attributes(:billing_date => Date.today + 1.months)
      else
        
        self.update_attributes(:billing_date => billing_date + 1.months)
      end
   
    elsif subscription.annually?
      if billing_date.nil?
        self.update_attributes(:billing_date => Date.today + 1.years)
      else
        self.update_attributes(:billing_date => billing_date + 1.years)
      end
    end
  end
  
  def set_status_ok
    self.update_attributes(:status => "ok") if !ok?
  end
  
  def set_canceled
    self.update_attributes(:status => "canceled")
  end
  
  def add_to_balance(cost)
    self.increment!(:balance, cost)
  end
  
  def create_cim_profile
    #Login to the gateway using your credentials in environment.rb
     #setup the user object to save
     @profile = {:profile => profile}
     #send the create message to the gateway API
     response = ::GATEWAYCIM.create_customer_profile(@profile)
     if response.success? and response.authorization
       self.customer_cim_id = response.authorization
       return true
     else
        raise response.message
        return false
      end

  end
  
  
  
  def create_payment_profile
   
    unless customer_payment_profile_id.nil?
      return false
    end
    @profile = {:customer_profile_id => customer_cim_id,
                  :payment_profile => {:bill_to => contact_info.to_hash, :payment => {:credit_card => credit_card.active_merchant_card}
                  }
              }
    
    response = GATEWAYCIM.create_customer_payment_profile(@profile)
    
    logger.info "payment_response #{response.to_yaml}"
    if response.success? and response.params['customer_payment_profile_id']
        self.customer_payment_profile_id = response.params['customer_payment_profile_id']
      return true
    end
    
    raise response.message
    return false
  end
  
  def profile
    return {:merchant_customer_id => self.id, :email => contact_info.email, :description => contact_info.full_name}
  end
  
  def set_status
    self.status = "ok"
  end
  
  def set_initial_balance
    self.balance = subscription.plan_price
  end
  
  
  def charge_amount(amount)
    response = GATEWAYCIM.create_customer_profile_transaction(:transaction => {:type => :auth_capture, 
                                               :amount => amount,
                                               :customer_profile_id => customer_cim_id,
                                               :customer_payment_profile_id => customer_payment_profile_id})

    transaction = self.transactions.create(:action => "purchase", :amount => amount, :response => response, :account => self)
    if response.success?
      self.update_attributes(:balance => balance - amount)
      return true
    else
      raise response.message
      return false
    end
  end
  
  def delete_profile
    if new_record?
      response = GATEWAYCIM::delete_customer_profile(:customer_profile_id => self.customer_cim_id) if customer_cim_id
    end
  end
  
end