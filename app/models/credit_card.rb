class CreditCard < ActiveRecord::Base
  
  before_validation :set_first_last_name, :on => :update  
  validate :validate_card
  validates_presence_of :card_verification
  validates_presence_of :first_name
  validates_presence_of :last_name, :message => "can't be blank"
  validates_presence_of :card_type, :message => "can't be blank"
  validates_presence_of :card_number, :message => "can't be blank"
  validates_presence_of :expiry_month, :message => "can't be blank"
  validates_presence_of :expiry_year, :message => "can't be blank"
  validates_numericality_of :expiry_month,  :message => "is not a number"
  validates_numericality_of :expiry_year,  :message => "is not a number"
  
  attr_accessor :card_type, :card_verification, :expiry_month, :expiry_year, :first_name, :last_name
  CARD_TYPES = [["Visa", "Visa"], ["Mastercard", "Mastercard"], ["American Express", "American Express" ], ["Discover", "Discover"]]
  
  MONTHS = (1..12).to_a
  YEARS = ((Date.today.year)..(Date.today.year + 8)).to_a
  
  belongs_to :subscription
  
  before_save :mask_card_number
  before_save :create_expiration_date
  before_save :update_payment_profile
  

  def validate_card
    unless active_merchant_card.valid?
        active_merchant_card.errors.full_messages.each do |message|
        case message
        when "First name connot be empty"
          errors[:card_name] = "cannot be empty"
        when "Last name cannot be empty"
          errors[:card_name] = "cannot be empty"
        when "Month is not a valid month"
          errors[:expiry_month] = "Month is not a valid month"
        when "Year expired"
          errors[:expiry_year] = "Year expired"
        when "Number is not a valid credit card number"
          errors[:card_number] = "is not a valid credit card number"
        when "Verification value is required"
          errors[:card_verification] = "value is required"
        end
      end
    end
  end
  
  def active_merchant_card
    @card_attributes ||= ActiveMerchant::Billing::CreditCard.new(
      :type               => card_type,
      :number             => card_number,
      :verification_value => card_verification,
      :month              => expiry_month,
      :year               => expiry_year,
      :first_name         => first_name,
      :last_name          => last_name
    )
  end
  
  def card_attributes=(cstring)
    @card_attributes = cstring
  end
  
  
  private
  
  
  def create_expiration_date
    self.expiration_date = "#{expiry_month}/#{expiry_year}"
  end
  
  
  def mask_card_number
    
    length = card_number.length
    masked_number = ""
    (1..(length - 4)).each do
      masked_number << "X"
    end
    masked_number << card_number[length - 4, length]
    self.card_number = masked_number
  end
  
  def update_payment_profile
    
    unless new_record?
      @profile = {:customer_profile_id => subscription.customer_cim_id,
                    :payment_profile => {:customer_payment_profile_id => subscription.customer_payment_profile_id, 
                                         :bill_to => subscription.contact_info.to_hash, 
                                         :payment =>  {:credit_card => active_merchant_card}
                    }
                }
        response = GATEWAYCIM.update_customer_payment_profile(@profile)
        if response.success?
          return true
        else
          raise response.message
          return false
        end
      end
    end

  def set_first_last_name
    self.first_name = subscription.contact_info.first_name
    self.last_name = subscription.contact_info.last_name
  end

end