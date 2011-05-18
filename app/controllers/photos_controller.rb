class PhotosController < ApplicationController
  
  before_filter :load_photo,  :only => [:show]
    
  def show
    render
  end
  
protected

  def load_photo
    @photo = Photo.find(params[:id])
  rescue ActiveRecord::RecordNotFound
    render :text => 'Photo not found', :status => 404
  end
  
end
