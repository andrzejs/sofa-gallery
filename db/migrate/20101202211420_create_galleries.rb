class CreateGalleries < ActiveRecord::Migration
  def self.up 
    create_table :galleries do |t|
      t.string :title
      t.string :slug
      t.text :description
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
