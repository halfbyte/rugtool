class AddRemoteUpdatedAtToEvents < ActiveRecord::Migration
  def self.up
    add_column :events, :remote_updated_at, :datetime
  end

  def self.down
    drop_column :events, :remote_updated_at
  end
end
