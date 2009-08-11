require 'test_helper'

class LoggingControllerTest < ActionController::TestCase
  test "/js/logger should route to LoggingController#create" do
    assert_recognizes({:controller => 'logging', :action => 'create'}, '/js/logger')
  end


  def valid_params
    {:message => "something happened", :line => "30", :url => "http://google.de/", :user_agent => "Ruby"}
  end

  test "should create a LogEntry object with the given params" do
    LogEntry.expects(:create).with(valid_params).once.returns(true)
    get :create, valid_params
  end

  test "should respond with 200 OK" do
    get :create, valid_params
    assert_response :ok
  end
end
