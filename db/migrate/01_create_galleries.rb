class CreateGalleries < ActiveRecord::Migration
  def self.up 
    create_table :galleries do |t|
      t.string :title
      t.string :slug
      t.text :description
      t.string :url
      t.integer :thumbnail_width, :default => "100"
      t.integer :full_size_width, :default => "800"
      t.integer :full_size_height, :default => "400"
      t.boolean :crop_full_size
      t.timestamps
    end
    add_index :galleries, :slug
  rescue
    self.down
    raise
  end

  def self.down
    drop_table :galleries
  end
end
