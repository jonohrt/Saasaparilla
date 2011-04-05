module AuthDotNet
  

  def self.included(base)
    base.class_eval do
      has_many :payment_profiles
      
    end
  end

 def get_payment_profile
   response = GATEWAYCIM.get_customer_payment_profile(:customer_profile_id => self.customer_cim_id, 
                                                     :customer_payment_profile_id => self.payment_profile_id)
   response.params["payment_profile"]
                                                            
 end
  
 private
 
 def create_cim_profile
#Login to the gateway using your credentials in environment.rb
   #setup the user object to save
   @user = {:profile => user_profile}
   #send the create message to the gateway API
   response = ::GATEWAYCIM.create_customer_profile(@user)
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
   response = GATEWAYCIM.update_customer_profile(:profile => user_profile.merge({
       :customer_profile_id => self.customer_cim_id
     }))
   if response.success?
     return true
   end
   return false
 end
 
 
 def user_profile
   return {:merchant_customer_id => self.id, :email => self.email, :description => self.full_name}
 end
 
 
end