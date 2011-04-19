# You can put this in /myengine/app/models/ and it will load it automatically (or put it in your engine lib directory and require it)
module Authorization
  module ClassMethods

     ActionController::Base.load_and_authorize_resource if Rails.env != "test"
     
    
   # Override this with your own authorization
     # ActionController::Base.before_filter do
     #           do_authorization
     #         end
     #   
  end
  module InstanceMethods
    
      #   
      # def do_authorization
      #        debugger
      #        puts "s"
      #     end
  end
end