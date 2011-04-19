class Transaction < ActiveRecord::Base
  
  belongs_to :subscription
  serialize :params
  belongs_to :billing_activity
  after_create :generate_billing_activity
  
  
  def response=(response)
    self.success       = response.success?
    self.authorization = response.authorization
    self.message       = response.message
    self.params        = response.params
  rescue ActiveMerchant::ActiveMerchantError => e
    self.success       = false
    self.authorization = nil
    self.message       = e.message
    self.params        = {}
  end
  
  scope :successful, lambda {
    where("success = ?", true)
    }
  scope :recent, order("created_at DESC")
    
  private
    def generate_billing_activity
      if success
        self.create_billing_activity(:message => BillingActivity::MESSAGES[:success], :subscription => subscription, :amount => amount)
      end
    end
end
