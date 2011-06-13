class Sofa::Photo < ActiveRecord::Base
  
  set_table_name :sofa_photos
  
  mount_uploader :photo, Sofa::ImageUploader
  
  # -- Relationships --------------------------------------------------------
  belongs_to :gallery
  
  # -- Callbacks ------------------------------------------------------------
  before_create :assign_position
  
  # -- Validations ----------------------------------------------------------
  validates :photo,
    :presence   => true,
    :integrity  => true,
    :processing => true
  
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