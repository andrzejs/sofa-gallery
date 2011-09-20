module Paperclip
  
  class Cropper < Thumbnail
    def transformation_command
      if crop_command
        crop_command + super.join(' ').sub(/ -crop \S+/, '').split(' ')
      else
        super
      end
    end
  end
  
  class ThumbCropper < Cropper
    def crop_command
      target = @attachment.instance
      if target.cropping_thumb?
        ["-crop", "#{target.thumb_crop_w}x#{target.thumb_crop_h}+#{target.thumb_crop_x}+#{target.thumb_crop_y}"]
      end
    end
  end
  
  class FullCropper < Cropper
    def crop_command
      target = @attachment.instance
      if target.cropping_full?
        ["-crop", "#{target.full_crop_w}x#{target.full_crop_h}+#{target.full_crop_x}+#{target.full_crop_y}"]
      end
    end
  end
  
end