class JsLogger::LoggingController < ApplicationController
  def create
    JsLogger::LogEntry.create(log_params)
    head :ok
  end

  protected

  def log_params
    %w(message line url user_agent backtrace).inject({}) do |hsh, key|
      val = params[key]
      hsh[key.to_sym] = val if val.present?
      hsh
    end
  end
end
