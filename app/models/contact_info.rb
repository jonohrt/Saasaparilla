class ContactInfo < ActiveRecord::Base
  
  belongs_to :account, :dependent => :destroy
  validates_presence_of :first_name
  validates_presence_of :last_name
  validates_presence_of :email
  validates_format_of   :email, :with => ::Authlogic::Regex.email
  validates_presence_of :address
  validates_presence_of :city
  validates_presence_of :state
  validates_presence_of :zip
  validates_format_of   :zip, :with => /^\d{5}$/
  validates_presence_of :country
  validates_presence_of :phone_number
  validates_format_of   :phone_number, :with => /^\d{3}-\d{3}-\d{4}$/ 
                                                                     
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
  
  
end