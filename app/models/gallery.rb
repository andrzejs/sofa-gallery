class Gallery < ActiveRecord::Base
  
  # == Relationships ========================================================
  
  has_many :photos, :dependent => :destroy
  
  # == Validations ==========================================================
  
  validates :title, :thumbnail_width, :full_size_width, :full_size_height,
    :presence => true
  validates :slug,
    :presence => true,
    :uniqueness => true,
    :format => {:with =>  /^\w[a-z0-9_-]*$/i}

end