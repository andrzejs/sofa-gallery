class ApplicationController < ActionController::Base
  protect_from_forgery
  helper :all
protected

  helper_method :render_gallery
  def render_gallery(slug)
    @gallery = Gallery.find_by_slug(slug)
    if (@gallery)
      render :partial => 'content/gallery'
    else
      render :text => 'Gallery not found.'
    end
  end
end
