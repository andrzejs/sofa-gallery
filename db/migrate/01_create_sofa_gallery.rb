class CreateSofaGallery < ActiveRecord::Migration
  def self.up 
    create_table :sofa_galleries do |t|
      t.string  :title
      t.string  :slug
      t.text    :description
      t.integer :thumb_max_width,   :null => false, :default => 200
      t.integer :thumb_max_height,  :null => false, :default => 150
      t.boolean :is_thumb_cropped,  :null => false, :default => true
      t.integer :full_max_width,    :null => false, :default => 800
      t.integer :full_max_height,   :null => false, :default => 600
      t.boolean :is_full_cropped,   :null => false, :default => true
      t.timestamps
    end
    add_index :sofa_galleries, :slug
    
    create_table :sofa_photos do |t|
      t.integer :gallery_id
      t.string  :title
      t.string  :slug
      t.text    :description
      t.string  :photo
      t.integer :position, :null => false, :default => 0
      t.timestamps
    end
    add_index :sofa_photos, [ :gallery_id, :position ]
    add_index :sofa_photos, :slug
  end

  def self.down
    drop_table :sofa_photos
    drop_table :sofa_galleries
  end
end