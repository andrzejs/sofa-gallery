class CreatePhotos < ActiveRecord::Migration
  def self.up
    create_table :photos do |t|
      t.string :title
      t.string :slug
      t.text :description
      t.integer :gallery_id
      t.integer :position
      t.string :image_file_name
      t.string :image_content_type
      t.integer :image_file_size
      t.timestamps
    end
    add_index :photos, [ :gallery_id, :position ]
    add_index :photos, :slug
  rescue
    self.down
    raise
  end

  def self.down
    drop_table :photos
  end
end
