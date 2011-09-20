class CreateSofaGallery < ActiveRecord::Migration
  def self.up 
    create_table :sofa_gallery_galleries do |t|
      t.string  :title
      t.string  :slug
      t.text    :description
      t.integer :gallery_width,       :null => false, :default => 640
      t.integer :full_width,          :null => false, :default => 600
      t.integer :full_width,          :null => false, :default => 600
      t.integer :full_height,         :null => false, :default => 450
      t.boolean :force_ratio_full,    :null => false, :default => false
      t.integer :thumb_width,         :null => false, :default => 150
      t.integer :thumb_height,        :null => false, :default => 150
      t.boolean :force_ratio_thumb,   :null => false, :default => true
      t.timestamps
    end
    add_index :sofa_gallery_galleries, :slug
    
    create_table :sofa_gallery_photos do |t|
      t.integer :gallery_id
      t.string  :title
      t.string  :slug
      t.text    :description
      t.string  :image_file_name
      t.string  :image_content_type
      t.integer :image_file_size
      t.integer :position, :null => false, :default => 0
      t.timestamps
    end
    add_index :sofa_gallery_photos, [ :gallery_id, :position ]
    add_index :sofa_gallery_photos, :slug
  end

  def self.down
    drop_table :sofa_gallery_photos
    drop_table :sofa_gallery_galleries
  end
end