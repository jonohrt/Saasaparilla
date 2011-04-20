 module Authentication
   module ClassMethods

   end
   module InstanceMethods
     def self.included(base)
       base.before_filter :require_current_billable
     end
     
     
     def require_current_billable
       if current_billable.nil?
         flash[:error] = "You must be logged in first."
         redirect_to '/'
       end
     end
  end
end