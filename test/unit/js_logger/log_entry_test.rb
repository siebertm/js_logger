require 'test_helper'

class JsLogger::LogEntryTest < ActiveSupport::TestCase
  should_validate_presence_of :message

  test "should generate the log_hash before create" do
    l = JsLogger::LogEntry.new(:message => "something happened", :line => "20", :user_agent => "Ruby")

    assert_nil l.log_hash

    l.save!
    l.reload

    assert_equal "acb8ced1b150c024848ccb34f29e0ca85ec29d44", l.log_hash
  end

end
