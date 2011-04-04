Factory.define :plan, :class => Plan do |f|
  f.name {"Gold"}
  f.billing_period  {"monthly"}
  f.price {12.99}
  
  #f.plan_extras {|plan_extras| [plan_extras.association(:plan_extra)]}
  
  
  
end