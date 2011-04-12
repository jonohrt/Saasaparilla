Factory.define :account, :class => Account do |f|
  f.customer_cim_id 
  f.customer_payment_profile_id
  f.balance 10
  f.status
  f.association :credit_card
  f.association :contact_info 
  f.association :subscription


end

Factory.define :contact_info, :class => ContactInfo do |f|
  f.first_name "Bob"
  f.last_name "Jones"
  f.email "bobjones@123.com"
  f.company "my company"
  f.address "123 fake st"
  f.city "seattle"
  f.state "wa"
  f.zip "98123"
  f.country "US"
  f.phone_number "206-123-2322"
end

Factory.define :credit_card, :class => CreditCard do |f|
  f.first_name "bob"
  f.last_name "Herman"
  f.card_type "Visa"
  f.card_number "4111111111111111"
  f.card_verification "545"
  f.expiry_month "10"
  f.expiry_year "2011"
 
end

Factory.define :plan, :class => Plan do |f|
  f.name "Gold"
  f.billing_period "monthly"
  f.price 12.99
  
  #f.plan_extras {|plan_extras| [plan_extras.association(:plan_extra)]}
  
  
  
end

Factory.define :payment, :class => Payment do |f| 
  f.status
  f.amount 20.00
end

Factory.define :subscription, :class => Subscription do |f|
  f.status
  f.association :plan
end

Factory.define :billing_activity, :class => BillingActivity do |f|
  f.created_at Time.now
  f.amount 12.00
  f.message "Thanks for your payment"
end
Factory.define :user, :class => User do |f|
  f.name "Ted"
  
end

Factory.define :account_with_all, :parent => :account do |account|
  
  account.before_create do |a|
    Factory(:contact_info, :account => a)
    Factory(:credit_card, :account => a)
    Factory(:subscription, :account => a, :plan => Factory(:plan, :name => "Gold"))
  end
  
end


