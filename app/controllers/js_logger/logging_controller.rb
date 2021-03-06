class JsLogger::LoggingController < ApplicationController
  def create
    log_entry = JsLogger::LogEntry.new(log_params)
    log_entry.save
    unless drop_mail_for?(log_entry)
      JsLogger::Mailer.deliver_new_log_entry(log_entry)
    end

    head :ok
  end

  protected

  def drop_mail_for?(log_entry)
    log_filters.any? do |rexp|
      rexp === log_entry.message
    end
  end

  def log_filters
    JsLogger::Mailer.filter_messages || []
  end

  def additional_data_proc
    JsLogger::Mailer.additional_data || proc {}
  end


  def log_params
    base = %w(message line url user_agent backtrace).inject({}) do |hsh, key|
      val = params[key]
      hsh[key.to_sym] = val if val.present?
      hsh
    end

    base.merge({:additional_data => additional_data_proc.call(self)})
  end
end
