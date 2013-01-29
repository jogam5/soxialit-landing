class Notifier < ActionMailer::Base
  def support_notification(sender)
    @sender = sender
    mail(:to => "beta.test@soxialit.com", :from => sender.email, :subject => "New")
  end
end
