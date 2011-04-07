class Plan < ActiveRecord::Base
  has_dynamic_attributes
  validates_presence_of :name, :message => "can't be blank"
  validates_presence_of :billing_period, :message => "can't be blank"
  validates_numericality_of :price, :message => "is not a number"
  validates_presence_of :price, :message => "can't be blank"
  
  has_many :subscriptions
  
  BILLING_PERIODS = ["Monthly", "Anually"]

  def method_missing(method, *args)
    
    if has_dynamic_attribute?("field_#{method}")
      return self.send("field_#{method}")
    end
    super
   end
       


end
