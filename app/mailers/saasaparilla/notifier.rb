class Saasaparilla::Notifier < ActionMailer::Base
  default :from => "notifications@example.com"

  def subscription_created(account)
    @account = account
    mail(:to => account.contact_info.email, :subject => "Subscription Created")
  end

  def invoice_created(account, invoice)
    @account = account
    @invoice = invoice
    mail(:to => account.contact_info.email, :subject => "Invoice Created")
  end

  def account_billing_successful(account, amount)
    @account = account
    @amount = amount
    mail(:to => account.contact_info.email, :subject => "Account Billing Successful")
  end

  def account_billing_failed(account)
    @account = account
    @url = edit_account_credit_card_url
    mail(:to => account.contact_info.email, :subject => "Account Billing Failed")
  end

  def pending_cancellation_notice(account)
    @account = account
    @url = edit_account_credit_card_url
    mail(:to => account.contact_info.email, :subject => "Your account will be cancelled soon")
  end

  def account_cancelled(account)
    @account = account
    mail(:to => account.contact_info.email, :subject => "Your has been cancelled")
  end
 
end
