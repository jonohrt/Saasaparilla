class Subscription < ActiveRecord::Base
  
  has_statuses "active", "overdue", "suspended", "pending_cancel", "canceled"
  has_many :transactions
  has_many :payments


  has_one :contact_info
  belongs_to :plan
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
  after_create :initial_bill
  after_create :send_subscription_created_email
  
  
  validates_presence_of :plan, :message => "can't be blank"
  
  scope :active, where("status != ?", "canceled")
  
  scope :all_billable_subscriptions, lambda {|date|
    where("billing_date < ? and balance > 0.0", date.to_time)
    }
  
  scope :all_invoiceable, lambda {|date|
    #find all subscriptions not been invoiced within the last month
    where("billing_date <= ? and (invoiced_on > ? OR invoiced_on is null)", date + 5.days, (date - 1.months).to_time)
    }

  Plan::BILLING_PERIODS.each do |period|
    define_method "#{period.downcase}?" do
      plan.billing_period.downcase == period.downcase
    end
  end
  class << self
    def find_and_bill_recurring_subscriptions
      #find_all_subscriptions need billing
      @billable_subscriptions = Subscription.active.all_billable_subscriptions(Date.today)
      for subscription in @billable_subscriptions
        
        begin
  
          subscription.bill!(subscription.balance)
        rescue
          subscription.billing_failed
        end
      end

    end
    
    def find_and_invoice_subscriptions
      @invoiceable_subscriptions = Subscription.active.all_invoiceable(Date.today)
      for subscription in @invoiceable_subscriptions
        subscription.invoice!
      end
    end
  end
  
  
  def initial_bill
    if Saasaparilla::CONFIG["trial_period"] > 0
      set_next_billing_date(Saasaparilla::CONFIG["trial_period"])
    else
      bill!
    end
    
  end
  def bill!(bill_amount = nil)
    bill_amount ||= balance
    if charge_amount(bill_amount)
      set_next_billing_date
      set_status_active if balance == 0.0
      send_billing_successful_email(bill_amount)
      return true
    end

  end
  
  def invoice!
    add_to_balance(plan.price)
    create_invoice
    self.update_attributes(:invoiced_on => Date.today)
    #if invoice_subscription
    #  set_next_invoice_date()
  end
  
  def cancel
    set_canceled
  end
  
  def billing_failed
    set_status_overdue
    send_billing_failed_email
    if billing_date < Date.today - Saasaparilla::CONFIG["grace_period"].days
      cancel
    end
  end
  
  private
  
  def create_invoice
    @invoice = Invoice.create(:subscription => self, :price => plan.price, :from => get_beginning_of_billing_cycle, :to => billing_date)
    
 
  end
  
  def get_beginning_of_billing_cycle
    if monthly?
      return billing_date - 1.months
    elsif annually?
      return billing_date - 1.years
    end
  end
  
  def set_next_billing_date(grace_period = 0)
    grace_period = grace_period - 1 if grace_period > 0
    if monthly?
      if billing_date.nil?
        self.update_attributes(:billing_date => Date.today + 1.months + grace_period.months)
      else
        
        self.update_attributes(:billing_date => billing_date + 1.months)
      end
   
    elsif annually?
      if billing_date.nil?
        self.update_attributes(:billing_date => Date.today + 1.years + grace_period.months)
      else
        self.update_attributes(:billing_date => billing_date + 1.years)
      end
    end
  end
  
  def set_status_active
    self.update_attributes(:status => "active") if !active?
  end
  
  def set_canceled
    self.update_attributes(:status => "canceled")
  end
  
  def set_status_overdue
    unless overdue?
      self.overdue_on = Date.today
    end
    self.status = "overdue"
    self.save

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
    self.status = "active"
  end
  
  def set_initial_balance
    self.balance = plan.price
  end
  
  
  def charge_amount(amount)
    response = GATEWAYCIM.create_customer_profile_transaction(:transaction => {:type => :auth_capture, 
                                               :amount => amount,
                                               :customer_profile_id => customer_cim_id,
                                               :customer_payment_profile_id => customer_payment_profile_id})

    transaction = self.transactions.create(:action => "purchase", :amount => amount, :response => response, :subscription => self)
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
  
  def send_subscription_created_email
    Saasaparilla::Notifier.subscription_created(self)
  end

  def send_billing_successful_email(amount)
    Saasaparilla::Notifier.billing_successful(self, amount)
  end

  def send_billing_failed_email
    
    #Saasaparilla::Notifier.billing_failed(self)
  end
  
end