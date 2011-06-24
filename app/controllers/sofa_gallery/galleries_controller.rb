class SofaGallery::GalleriesController < ApplicationController
  
  def show
    @gallery = Sofa::Gallery.find(params[:id])
  rescue ActiveRecord::RecordNotFound
    render :text => 'Gallery not found', :status => 404
    flash[:error] = 'Gallery not found'
  end
  
end