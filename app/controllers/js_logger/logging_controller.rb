class JsLogger::LoggingController < ApplicationController
  def create
    log_entry = JsLogger::LogEntry.new(log_params)
    log_entry.save
    JsLogger::Mailer.deliver_new_log_entry(log_entry)

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
