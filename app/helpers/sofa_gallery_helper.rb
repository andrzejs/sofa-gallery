module SofaGalleryHelper
  
  def gallery_form_for(record_or_name_or_array, *args, &proc)
    options = args.extract_options!
    form_for(
      record_or_name_or_array,
      *(args << options.merge(:builder => SofaGallery.config.form_builder.to_s.constantize)),
      &proc
    )
  end
end