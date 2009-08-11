class CreateLogEntries < ActiveRecord::Migration
  def self.up
    create_table :log_entries do |t|
      t.string :log_hash
      t.string :message
      t.string :line
      t.string :user_agent
      t.string :url
      t.text :backtrace

      t.timestamps
    end
  end

  def self.down
    drop_table :log_entries
  end
end
