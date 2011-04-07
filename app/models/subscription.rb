class Subscription < ActiveRecord::Base
  
  belongs_to :account
  belongs_to :plan
  
  before_validation :set_status, :on => :create
  validates_presence_of :plan, :message => "can't be blank"
  
  has_statuses  :pending, :active, :issue, :canceled
  
  after_create :do_inital_billing
  
  def plan_price
    plan.price
  end
  

  
  private
  
  def set_status
    self.status = :pending 
  end
  
  def do_inital_billing
    #TODO
    
  end
  
  def activate_subscription
    #TODO
    self.update_attributes(:status => :active) 
  end
  
  
  
end