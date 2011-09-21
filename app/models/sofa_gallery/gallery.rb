class SofaGallery::Gallery < ActiveRecord::Base
  
  cms_is_categorized if defined?(ComfortableMexicanSofa)

  set_table_name :sofa_gallery_galleries
  
  # -- Relationships --------------------------------------------------------
  has_many :photos, :dependent => :destroy
  
  # -- Validations ----------------------------------------------------------
  validates :title,
    :presence => true
    
  validates :slug,
    :presence   => true,
    :uniqueness => true,
    :format     => { :with =>  /^\w[a-z0-9_-]*$/i }
    
end