class Plan < ActiveRecord::Base
  has_dynamic_attributes
  validates_presence_of :name, :message => "can't be blank"
  validates_presence_of :billing_period, :message => "can't be blank"
  validates_numericality_of :price, :message => "is not a number"
  validates_presence_of :price, :message => "can't be blank"
  
  has_many :subscriptions

  attr_accessible :name, :price, :billing_period
  
  BILLING_PERIODS = ["Monthly", "Annually"]
  
  def respond_to?(method_sym, include_private = false)
      @column_names = []
      unless dynamic_attributes.nil?
        dynamic_attributes.each do |dm|
           @column_names << dm[0].gsub("field_", "")
         end
        if @column_names.include? method_sym.to_s
          return  true
        end
      end

    super
  end
    
  def method_missing(method, *args)
    
    if has_dynamic_attribute?("field_#{method}")
      return self.send("field_#{method}")
    end
    super
   end
       


end
