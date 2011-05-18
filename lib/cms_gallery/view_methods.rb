module CmsGallery::ViewMethods
  def render_gallery(slug, type)
    @gallery = Gallery.find_by_slug(slug)
    if (@gallery)
      if (type == 'carousel')
        render :partial => 'content/carousel'
      elsif (type == 'thumbnails_with_lightbox')
        render :partial => 'content/thumbnails'
      else
        render :text => 'Gallery type not found.'
      end
    else
      render :text => 'Gallery not found.'
    end
  end
end