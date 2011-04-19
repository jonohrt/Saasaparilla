class ContactInfo < ActiveRecord::Base
  
  belongs_to :subscription, :dependent => :destroy
  validates_presence_of :first_name, :last_name, :email, :address, :city, :state, :zip, :country
  validates_format_of   :email, :with => ::Authlogic::Regex.email
  validates_format_of   :zip, :with => /^\d{5}$/
  validates_numericality_of :phone_area_code, :phone_prefix, :phone_suffix
  validates_length_of :phone_area_code, :is => 3
  validates_length_of :phone_prefix, :is => 3
  validates_length_of :phone_suffix, :is => 4
  validates_format_of :phone_number, :with => /\d\d\d-\d\d\d-\d\d\d\d/
    
  before_validation :update_phone_number
  # before_save :validate_phone_number
  
  attr_accessor :phone_area_code, :phone_prefix, :phone_suffix

  def phone_area_code
    self.phone_number.split('-')[0] if self.phone_number
  end

  def phone_prefix
    self.phone_number.split('-')[1] if self.phone_number
  end

  def phone_suffix
    self.phone_number.split('-')[2] if self.phone_number
  end

  def full_name
    "#{first_name} #{last_name}"
  end
  
  def to_hash
    return {:first_name => first_name,
            :last_name => last_name,
            :address => address,
            :company => company,
            :city => city,
            :state => state,
            :zip => zip,
            :country => "US",
            :phone_number => phone_number}
  end
  
  private
  
  def update_phone_number
    if @phone_area_code && @phone_prefix && @phone_suffix
      self.phone_number = "#{@phone_area_code}-#{@phone_prefix}-#{@phone_suffix}"
    end
  end

  # def validate_phone_number
  #   return_value = true
  #   unless self.phone_area_code.length == 3
  #     self.errors.add(:base, "Area code must be three digits.")
  #     return_value = false
  #   end
  #   unless (/[0-9]/).match(self.phone_area_code)
  #     self.errors.add(:base, "Area code must be numbers only.")
  #     return_value = false
  #   end
  #   unless self.phone_prefix.length == 3
  #     self.errors.add(:base, "Phone prefix must be three digits.")
  #     return_value = false
  #   end
  #   unless (/[0-9]/).match(self.phone_prefix)
  #     self.errors.add(:base, "Phone prefix must be numbers only.")
  #     return_value = false
  #   end
  #   unless self.phone_suffix.length == 4
  #     self.errors.add(:base, "Phone suffix must be four digits.")
  #     return_value = false
  #   end
  #   unless (/[0-9]/).match(self.phone_suffix)
  #     self.errors.add(:base, "Phone suffix must be numbers only.")
  #     return_value = false
  #   end
  #   return_value
  # end
  
end