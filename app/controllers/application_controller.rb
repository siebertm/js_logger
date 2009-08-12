if Rails.env.test?
  class ApplicationController < ActionController::Base
  end
end
