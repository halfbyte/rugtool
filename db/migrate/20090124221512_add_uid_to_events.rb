class AddUidToEvents < ActiveRecord::Migration
  def self.up
    add_column :events, :uid, :string,
    execute "UPDATE events SET uid = url WHERE url IS NOT NULL"
  end

  def self.down
    remove_column :events, :uid
  end
end
