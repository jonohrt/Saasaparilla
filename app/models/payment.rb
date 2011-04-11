class Payment < ActiveRecord::Base
  before_validation :set_status_pending, :on => :create
  before_update :charge_account
  validate :valid_amount
  validates_presence_of :account_id
  validates_presence_of :amount, :message => "can't be blank"
  has_statuses "pending", "paid", "failed"
  belongs_to :account
  
  
  
  
  def valid_amount
    if amount < 0
      errors[:amount] = "cannot be less than 0"
    end
    if amount > account.balance
      errors[:amount] = "cannot be more than your balance"
    end
    if amount == 0
      error[:amount] = "cannot be zero"
    end
  end
  
  
  private
  
  def charge_account

    if account.bill!(amount)
      self.status = "paid"
    end
    
  end
  def set_status_pending
    self.status = "pending"
  end
end