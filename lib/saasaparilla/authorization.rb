module Authorization
  module ClassMethods
  
  end
  module InstanceMethods
    def self.included(base)
      if Saasaparilla::CONFIG["authorization"] == "cancan"
        base.rescue_from CanCan::AccessDenied do |exception|
          redirect_to '/'
          flash[:error] = exception.to_s
        end
        
        base.load_and_authorize_resource 
        
      end
        # Override this module an initializer with Authorization::InstanceMethods.module_eval and add your own authorization
       # base.before_filter :custom_method
    end
    

     # def custom_method
     
     # end
    
  end
end