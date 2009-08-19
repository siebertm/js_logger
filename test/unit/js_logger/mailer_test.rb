require 'test_helper'

class JsLogger::MailerTest < ActionMailer::TestCase
  test "new_log_entry" do
    Time.stubs(:now).returns(Time.parse("2009-08-10 10:00:00"))
    @log_entry = JsLogger::LogEntry.create(
      :message => "something happened",
      :line => "20",
      :url => "http://google.com",
      :user_agent => "Ruby",
      :backtrace => "foo.js:12\nbar.js:1"
    )

    JsLogger::Mailer.mail_to = "me@samedi.de"

    @expected.subject = 'JSLogger Error "something happened"'
    @expected.from    = "jslogger@samedi.de"
    @expected.to      = "me@samedi.de"
    @expected.body    = read_fixture('new_log_entry')
    @expected.date    = Time.now

    assert_equal @expected.encoded, JsLogger::Mailer.create_new_log_entry(@log_entry).encoded
  end

end
