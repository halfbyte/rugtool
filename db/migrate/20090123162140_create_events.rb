class CreateEvents < ActiveRecord::Migration
  def self.up
    create_table :events do |t|
      t.datetime :starts_at
      t.string :title
      t.text :description
      t.string :url

      t.timestamps
    end
  end

  def self.down
    drop_table :events
  end
end
