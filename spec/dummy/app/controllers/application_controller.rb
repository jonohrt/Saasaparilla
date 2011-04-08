class ApplicationController < ActionController::Base
  protect_from_forgery
  
  def current_billable
    if User.count == 0
      User.create
    end
    User.first
  end
    
end
