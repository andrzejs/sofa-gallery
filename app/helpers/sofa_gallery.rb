module SofaGallery
  
  def render_gallery(slug, type = 'thumbnails')
    @gallery = Gallery.find_by_slug(slug)
    if (@gallery)
      render :partial => "content/#{type}"
    else
      render :text => 'Gallery not found.', :status => 404
    end
  end
  
end