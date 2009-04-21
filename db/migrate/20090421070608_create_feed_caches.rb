class CreateFeedCaches < ActiveRecord::Migration
  def self.up
    create_table :feed_caches do |t|
      t.string :title
      t.string :description
      t.datetime :posted_at
      t.string :source
      t.string :url
      t.string :source_url

      t.timestamps
    end
  end

  def self.down
    drop_table :feed_caches
  end
end
