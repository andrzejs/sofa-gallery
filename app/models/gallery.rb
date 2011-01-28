class Gallery < ActiveRecord::Base  
  # -- Validations ----------------------------------------------------------
  
  validates_presence_of :title, :slug
  validates_uniqueness_of :slug
  validates_format_of     :slug,
    :with   => /^\w[a-z0-9_-]*$/i
  
  # -- Relationships --------------------------------------------------------
  
  has_many :photos, :dependent => :destroy
end
