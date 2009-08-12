require "digest/sha1"

class JsLogger::LogEntry < ActiveRecord::Base
  set_table_name :js_logger_log_entries

  validates_presence_of :message

  before_save :generate_log_hash

  protected

  def generate_log_hash
    self.log_hash = Digest::SHA1.hexdigest(message.to_s + line.to_s + url.to_s + user_agent.to_s)
  end
end
