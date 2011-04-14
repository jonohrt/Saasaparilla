class Saasaparilla::Notifier < ActionMailer::Base
  default :from => Saasaparilla::CONFIG["from_email"]

  def subscription_created(subscription)
    @subscription = subscription
    mail(:to => subscription.contact_info.email, :subject => "Subscription Created")
  end

  def invoice_created(subscription, invoice)
    @subscription = subscription
    @invoice = invoice
    mail(:to => subscription.contact_info.email, :subject => "Invoice Created")
  end

  def billing_successful(subscription, amount)
    @subscription = subscription
    @amount = amount
    mail(:to => subscription.contact_info.email, :subject => "Account Billing Successful")
  end

  def billing_failed(subscription)

    @subscription = subscription
    @url = edit_subscription_credit_card_url
    mail(:to => subscription.contact_info.email, :subject => "Account Billing Failed")
  end

  def pending_cancellation_notice(subscription)
    @subscription = subscription
    @url = edit_subscription_credit_card_url
    mail(:to => subscription.contact_info.email, :subject => "Your subscription will be cancelled soon")
  end

  def subscription_cancelled(subscription)
    @subscription = subscription
    mail(:to => subscription.contact_info.email, :subject => "Your subscription has been cancelled")
  end
 
end
