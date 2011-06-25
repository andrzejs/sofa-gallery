module SofaGalleryHelper
  
  def gallery_form_for(record_or_name_or_array, *args, &proc)
    options = args.extract_options!
    form_for(
      record_or_name_or_array,
      *(args << options.merge(:builder => SofaGallery.config.form_builder.to_s.constantize)),
      &proc
    )
  end
  
  def render_gallery(slug, type = 'thumbnails')
    @gallery = Sofa::Gallery.find_by_slug(slug)
    if (@gallery)
      render :partial => "content/#{type}"
    else
      render :text => 'Gallery not found.', :status => 404
    end
  end
  
end