class GroupsAddLocationFields < ActiveRecord::Migration
  def self.up
    add_column :groups, :lat, :float
    add_column :groups, :lng, :float
    add_column :groups, :location, :string
  end

  def self.down
    remove_column :groups, :location
    remove_column :groups, :lng
    remove_column :groups, :lat
  end
end
