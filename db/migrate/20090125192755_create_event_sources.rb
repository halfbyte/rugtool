class CreateEventSources < ActiveRecord::Migration
  def self.up
    create_table :event_sources do |t|
      t.string :url
      t.string :source_type
      t.datetime :accepted_at
      t.string :title

      t.timestamps
    end
  end

  def self.down
    drop_table :event_sources
  end
end
