require File.dirname(__FILE__) + '/../../test_helper'

class JsLogger::LoggingControllerTest < ActionController::TestCase
  tests JsLogger::LoggingController

  test "/js/logger should route to LoggingController#create" do
    assert_recognizes({:controller => 'js_logger/logging', :action => 'create'}, '/js/logger')
  end


  def valid_params
    {:message => "something happened", :line => "30", :url => "http://google.de/", :user_agent => "Ruby"}
  end

  test "should create a LogEntry object with the given params" do
    log_entry = JsLogger::LogEntry.new(valid_params)
    JsLogger::LogEntry.expects(:new).with(valid_params).once.returns(log_entry)
    log_entry.expects(:save).returns(true)
    get :create, valid_params
  end

  test "should send an email with the log message" do
    JsLogger::Mailer.expects(:deliver_new_log_entry)
    get :create, valid_params
  end

  test "should add additional data when configured" do
    begin
      additional_data_proc = proc do |controller|
      end
      JsLogger::Mailer.additional_data = additional_data_proc

      additional_data_proc.expects(:call).once
      get :create, valid_params
    ensure
      JsLogger::Mailer.additional_data = nil
    end
  end


  test "should send an email when the message didnt matche any of JsLogger::Mailer.filter_messages" do
    begin
      JsLogger::Mailer.filter_messages = [
        /nothing happened/,
        /bar/
      ]

      JsLogger::Mailer.expects(:deliver_new_log_entry).once
      get :create, valid_params
    ensure
      JsLogger::Mailer.filter_messages = []
    end
  end

  test "should not send an email when the message matches one of JsLogger::Mailer.filter_messages" do
    begin
      JsLogger::Mailer.filter_messages = [
        /something/,
        /bar/
      ]

      JsLogger::Mailer.expects(:deliver_new_log_entry).never
      get :create, valid_params
    ensure
      JsLogger::Mailer.filter_messages = []
    end
  end

  test "should respond with 200 OK" do
    get :create, valid_params
    assert_response :ok
  end
end
