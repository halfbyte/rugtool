class CreatePlanetFeeds < ActiveRecord::Migration
  def self.up
    create_table :planet_feeds do |t|
      t.string :title
      t.string :feed_url
      t.string :source_url
      t.datetime :accepted_at

      t.timestamps
    end
  end

  def self.down
    drop_table :planet_feeds
  end
end
