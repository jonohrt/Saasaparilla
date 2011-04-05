class BillingProfile < ActiveRecord::Base
  
  #validates_presence_of :customer_cim_id
  belongs_to :billable, :polymorphic => true
  has_one :address, :as => :billing_address
  
  before_create :create_cim_profile
  #before_create :create_payment_profile
  attr_accessor :card_type, 
                :card_number, 
                :card_verification, 
                :first_name, 
                :last_name, 
                :save_card_info,
                :payment_profile_id,
                :use_saved_profile,
                :expiration_date
  
  def validate_card
    unless credit_card.valid?
      credit_card.errors.full_messages.each do |message|
        case message
        when "First name connot be empty"
          errors[:card_name] = "cannot be empty"
        when "Last name cannot be empty"
          errors[:card_name] = "cannot be empty"
        when "Month is not a valid month"
          errors[:expiration_date] = "- Month is not a valid month"
        when "Year expired"
          errors[:expiration_date] = "- Year expired"
        when "Number is not a valid credit card number"
          errors[:card_number] = "is not a valid credit card number"
        when "Verification value is required"
          errors[:card_verification] = "value is required"
        end
      end
    end
  end
  
 private
   def create_cim_profile
  #Login to the gateway using your credentials in environment.rb
     #setup the user object to save
     @profile = {:profile => profile}
     #send the create message to the gateway API
     response = ::GATEWAYCIM.create_customer_profile(@profile)
     begin
       if response.success? and response.authorization
         self.customer_cim_id = response.authorization
         return true
       end
     rescue
       raise response.message
       return false
     end
   end

   def update_cim_profile
     if not self.customer_cim_id
       return false
     end
     response = GATEWAYCIM.update_customer_profile(:profile => profile.merge({
         :customer_profile_id => self.customer_cim_id
       }))
     if response.success?
       return true
     end
     return false
   end
   
   
   def profile
     return {:merchant_customer_id => self.id, :email => "jon@123.com", :description => "self.full_name"}
   end
end
