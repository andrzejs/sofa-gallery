class SofaGallery::GalleriesController < ApplicationController
  
  def index
    @galleries = SofaGallery::Gallery.all
  rescue ActiveRecord::RecordNotFound
    render :text => 'Gallery not found', :status => 404
  end
  
  def show
    @gallery = SofaGallery::Gallery.find(params[:id])
  rescue ActiveRecord::RecordNotFound
    render :text => 'Gallery not found', :status => 404
  end
  
end