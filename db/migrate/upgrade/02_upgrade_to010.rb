class UpgradeTo010 < ActiveRecord::Migration
  def change
    add_column :sofa_gallery_galleries, :force_ratio_full, :boolean, :null => false, :default => true
    rename_column :sofa_gallery_galleries, :force_ratio, :force_ratio_thumb
  end
end

