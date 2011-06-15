class Sofa::Photo < ActiveRecord::Base
  
  set_table_name :sofa_photos
  
  upload_options = (SofaGallery.config.upload_options || {}).merge(
    :styles => lambda { |image|
      g = image.instance.gallery
      f_settings = "#{g.full_max_width}x#{g.full_max_height}#{g.is_full_cropped?? '#' : '>'}"
      t_settings = "#{g.thumb_max_width}x#{g.thumb_max_height}#{g.is_thumb_cropped?? '#' : '>'}"
      {
        :full         => { :geometry => f_settings, :processors => [:cropper] },
        :thumb        => { :geometry => t_settings, :processors => [:cropper] },
        :admin_full   => '800x600>',
        :admin_thumb  => '40x30#'
      }
    }
  )
  has_attached_file :image, upload_options
  
  attr_accessor :crop_x, :crop_y, :crop_w, :crop_h
  
  # -- Relationships --------------------------------------------------------
  belongs_to :gallery
  
  # -- Callbacks ------------------------------------------------------------
  before_create :assign_position
  after_update :reprocess_image, :if => :cropping?
  
  # -- Validations ----------------------------------------------------------
  validates :gallery_id,
    :presence => true
  validates_attachment_presence :image,
    :message      => 'There was no file uploaded!'
  validates_attachment_content_type :image,
    :content_type => %w(image/jpeg image/pjpeg image/gif image/png image/x-png),
    :message      => 'Please only upload .jpg, .jpeg, .gif or .png files.'
  validates_attachment_size :image,
    :less_than    => 5.megabytes
      
  # -- Scopes ---------------------------------------------------------------
  default_scope order(:position)
  
  # -- Instance Methods -----------------------------------------------------
  def image_geometry(style = :original)
    @geometry ||= {}
    @geometry[style] ||= Paperclip::Geometry.from_file(image.path(style))
  end
  
  def cropping?
    !crop_x.blank? && !crop_y.blank? && !crop_w.blank? && !crop_h.blank?
  end
  
private
  
  def assign_position
    max = self.gallery.photos.maximum(:position)
    self.position = max ? max + 1 : 0
  end
  
  def reprocess_image
    image.reprocess!
  end
  
end