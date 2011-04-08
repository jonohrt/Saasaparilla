class Account < ActiveRecord::Base
  
  has_statuses :ok, :overdue, :suspended
  has_many :transactions
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
  after_create :do_inital_billing
  
  
  def do_inital_billing
    amount = balance
    if charge_amount(balance)
      self.update_attributes(:status => :ok) if !ok?
    end
  end
  
  private
  
  

  
  
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
    self.status = :ok
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
      self.update_attributes(:balance => 0.0)
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