class Subscription < ActiveRecord::Base
  
  belongs_to :account
  belongs_to :plan
  
  before_validation :set_status, :on => :create
  validates_presence_of :plan, :message => "can't be blank"
  
  has_statuses  "pending", "active", "issue", "canceled"
  

  
  def plan_price
    plan.price
  end
  
  Plan::BILLING_PERIODS.each do |period|
    define_method "#{period.downcase}?" do
      plan.billing_period == period
    end
  end
  
  private
  
  def set_status
    self.status = "pending" 
  end
  

  
  def activate_subscription

    self.update_attributes(:status => "active") 
  end
  
  
  
end