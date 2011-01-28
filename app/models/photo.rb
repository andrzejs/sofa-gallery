class Photo < ActiveRecord::Base
  
  # -- AR Extensions --------------------------------------------------------
  
  has_attached_file :image,
    :styles => {
      :thumb => "130x130#",
      :medium => "900x600>",
      :large => "960x960>"
    },
    :storage => :s3, 
    :s3_credentials => "#{Rails.root.to_s}/config/s3.yml", 
    :path => "/:style/:filename"
    
  # -- Validations ----------------------------------------------------------
  
  validates_attachment_presence :image,
      :message      => 'There was no file uploaded!'
    validates_attachment_content_type :image, 
      :content_type => %w[ image/jpeg image/pjpeg image/gif image/png image/x-png ],
      :message      => 'Please only upload .jpg, .jpeg, .gif or .png files.'
    
  # -- Relationships --------------------------------------------------------
  
  belongs_to :gallery, :class_name => 'Gallery'
  
  # -- Named Scope ----------------------------------------------------------
  
  default_scope :order => "position"
  
end