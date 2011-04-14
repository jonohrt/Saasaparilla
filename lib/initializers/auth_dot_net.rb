if Rails.env == "production"
  ::GATEWAYCIM = ActiveMerchant::Billing::AuthorizeNetCimGateway.new(
     :login => Saasaparilla::CONFIG["auth_dot_net_login"],
     :password => Saasaparilla::CONFIG["auth_dot_net_password"]     
     )
elsif Rails.env == "test"
  ActiveMerchant::Billing::Base.mode = :test
  ::GATEWAYCIM = AuthorizeNetCimGatewayTest.new
  ::GATEWAY = AuthorizeNetGatewayTest.new
  ::EXPRESSGATEWAY = ActiveMerchant::Billing::BogusGateway.new
else
  
  ActiveMerchant::Billing::Base.mode = :test
  ::GATEWAYCIM = ActiveMerchant::Billing::AuthorizeNetCimGateway.new(
    :login => Saasaparilla::CONFIG["auth_dot_net_login"],
    :password => Saasaparilla::CONFIG["auth_dot_net_password"],
    :test => true
    )

  ActiveMerchant::Billing::Base.gateway_mode = :test
  ActiveMerchant::Billing::Base.integration_mode = :test
end