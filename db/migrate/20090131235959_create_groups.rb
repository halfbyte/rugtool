class CreateGroups < ActiveRecord::Migration
  def self.up
    create_table :groups do |t|
      t.string :title
      t.string :url_slug
      t.text :description
      t.string :url

      t.timestamps
    end
  end

  def self.down
    drop_table :groups
  end
end
