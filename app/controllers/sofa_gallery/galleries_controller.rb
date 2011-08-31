class SofaGallery::GalleriesController < ApplicationController
  
  def show
    @gallery = SofaGallery::Gallery.find(params[:id])
  rescue ActiveRecord::RecordNotFound
    render :text => 'Gallery not found', :status => 404
  end
  
end