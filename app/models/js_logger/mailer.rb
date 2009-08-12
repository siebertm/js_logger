class JsLogger::Mailer < ActionMailer::Base
  cattr_accessor :mail_to

  def new_log_entry(log_entry)
    subject    "JSLogger Error \"#{log_entry.message}\" (#{log_entry.log_hash})"
    recipients self.class.mail_to
    from       'jslogger@samedi.de'
    sent_on    Time.now

    body       :log_entry => log_entry
  end

end
