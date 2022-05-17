class CreateShortUrls < ActiveRecord::Migration[7.0]
  def change
    create_table :short_urls do |t|
      t.text :url
      t.string :shortcode
      t.datetime :last_accessed_at
      t.integer :counts

      t.timestamps
    end
    add_index :short_urls, :shortcode
    add_index :short_urls, :last_accessed_at
    add_index :short_urls, :counts
  end
end
