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

  class << self
    def find_and_bill_recurring_accounts
      #find_all_accounts need billing
      @billable_accounts = Account.active.all_billable_accounts(Date.today)
      for account in @billable_accounts
        account.bill!(account.balance)
        account.set_next_billing_date
      end

    end
  end
  
  def bill!(bill_amount = nil)
    bill_amount ||= balance
    if charge_amount(bill_amount)
      set_status_ok if balance == 0.0
      return true
    end
  end
  
  def cancel
    set_canceled
  end
  def set_next_billing_date
    
    if subscription.monthly?
      self.update_attributes(:billing_date => billing_date + 1.months)
   
    elsif subscription.annually?
      self.update_attributes(:billing_date => billing_date + 1.years)
    end
  end
  
  private
  

  
  def set_status_ok
    self.update_attributes(:status => "ok") if !ok?
  end
  
  def set_canceled
    self.update_attributes(:status => "canceled")
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