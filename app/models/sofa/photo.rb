class Sofa::Photo < ActiveRecord::Base
  
  set_table_name :sofa_photos
  
  mount_uploader :photo, PhotoUploader
  
  # -- Relationships --------------------------------------------------------
  belongs_to :gallery
  
  # -- Callbacks ------------------------------------------------------------
  before_create :assign_position
  
  # -- Scopes ---------------------------------------------------------------
  default_scope order(:position)
  
  scope :top, lambda { |limit|
    limit(limit)
  }
  
private
  
  def assign_position
    max = self.gallery.photos.maximum(:position)
    self.position = max ? max + 1 : 0
  end
  
end