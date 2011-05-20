class Photo < ActiveRecord::Base
  
  # -- AR Extensions --------------------------------------------------------
    
  has_attached_file :image,  
    CmsGallery.config.upload_photo_options.merge(:styles => lambda { |attachment| 
      gallery = attachment.instance.gallery
      crop = (gallery.crop_full_size ? '#' : '>')
      full = "#{gallery.full_size_width}x#{gallery.full_size_height}#{crop}"
      thumb = "#{gallery.thumbnail_width}x#{gallery.thumbnail_width}#"
      { :full => full,
        :thumbnail => thumb }
    })

  # -- Validations ----------------------------------------------------------
  
  validates_attachment_presence :image,
    :message      => 'There was no file uploaded!'
  validates_attachment_content_type :image, 
    :content_type => %w[ image/jpeg image/pjpeg image/gif image/png image/x-png ],
    :message      => 'Please only upload .jpg, .jpeg, .gif or .png files.'
  validates_attachment_size :image, 
    :less_than => 6.megabytes
    
  # -- Relationships --------------------------------------------------------
  
  belongs_to :gallery, :class_name => 'Gallery'
  
  # -- Callbacks ------------------------------------------------------------
  
  before_validation :assign_position,
                    :on => :create
  
  # -- Named Scope ----------------------------------------------------------
  
  default_scope order(:position)
  
  scope :top, lambda { |limit|
    { :limit => limit }
  }
  
  
  attr_protected :image_file_name, :image_content_type, :image_size
  
private
  
  def assign_position
    max = self.gallery.photos.maximum(:position)
    self.position = max ? max + 1 : 0
  end
  
end